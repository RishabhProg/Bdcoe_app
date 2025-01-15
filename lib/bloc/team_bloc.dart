import 'dart:convert';
import 'package:bdcoe/bloc/team_event.dart';
import 'package:bdcoe/bloc/team_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DropdownBloc extends Bloc<Dropdownchangedevent, DropdownChangedstate> {
  DropdownBloc() : super(DropdownChangedstate('2nd Year')) {
    on<Dropdownchangedevent>((event, emit) {
      emit(DropdownChangedstate(event.newValue));
    });
  }
}

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(MemberInitial()) {
    on<FetchMembers>(_fetchMembers);
  }

  Future<void> _fetchMembers(
      FetchMembers event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String cacheKey = 'members_${event.year}';

      // Check if the data is already cached
      if (prefs.containsKey(cacheKey)) {
        // If cached data exists, load it
        final cachedData = prefs.getString(cacheKey);
        final cachedMembers =
            List<Map<String, dynamic>>.from(json.decode(cachedData!));
        emit(MemberLoaded(cachedMembers));
      } else {
        // If no cached data, make the API call
        final response = await http.get(
          Uri.parse('https://bdcoe-backend.vercel.app/api/v1/member'),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final members = List<Map<String, dynamic>>.from(jsonResponse['data']);

          // Filter members based on year
          final filteredMembers = event.year == 420
              ? members
                  .where((member) =>
                      member['graduation'] <= DateTime.now().year - 1)
                  .toList()
              : members
                  .where((member) => member['graduation'] == event.year)
                  .toList();

          // Save the data locally for future use
          await prefs.setString(cacheKey, json.encode(filteredMembers));
          emit(MemberLoaded(filteredMembers));
        } else {
          emit(MemberError('Failed to fetch members'));
        }
        print("api called");
      }

      print("API fetched or loaded from cache");
    } catch (e) {
      print(e.toString());
      emit(MemberError(e.toString()));
    }
  }
}
