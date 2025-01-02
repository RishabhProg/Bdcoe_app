import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_detail_event.dart';
import 'event_detail_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<FetchEvents>(_onFetchEvents);
  }

  Future<void> _onFetchEvents(
      FetchEvents event,
      Emitter<EventState> emit,
      ) async {
    emit(EventLoading());
    try {
      final response = await http.get(
        Uri.parse('https://bdcoe-backend.vercel.app/api/v1/event'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<Map<String, dynamic>> events =
        (jsonResponse['data'] as List).cast<Map<String, dynamic>>();
        emit(EventLoaded(events));
      } else {
        emit(EventError('Failed to load events. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(EventError('An error occurred: $e'));
    }
  }
}