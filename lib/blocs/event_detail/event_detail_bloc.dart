import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_detail_event.dart';
import 'event_detail_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<FetchEvents>(_onFetchEvents);
  }

  Future<void> _onFetchEvents(
    FetchEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    // First, try to fetch data from local storage
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_events');

    if (cachedData != null) {
      // If cached data exists, use it and emit EventLoaded
      final List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(json.decode(cachedData));
      emit(EventLoaded(events));
    } else {
      try {
        // If no cached data, fetch from API
        final response = await http.get(
          Uri.parse('https://bdcoe-backend.vercel.app/api/v1/event'),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final List<Map<String, dynamic>> events = (jsonResponse['data'] as List).cast<Map<String, dynamic>>();

          // Cache the data locally for future use
          await prefs.setString('cached_events', json.encode(events));

          emit(EventLoaded(events));
        } else {
          emit(EventError('Failed to load events. Status code: ${response.statusCode}'));
        }
      } catch (e) {
        emit(EventError('An error occurred: $e'));
      }
    }
  }
}
