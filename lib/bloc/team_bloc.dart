import 'dart:convert';
import 'package:bdcoe/bloc/team_event.dart';
import 'package:bdcoe/bloc/team_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(MemberInitial()) {
    on<FetchMembers>(_fetchMembers);
  }

  Future<void> _fetchMembers(
      FetchMembers event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      final response = await http.get(
        Uri.parse('https://bdcoe-backend.vercel.app/api/v1/member'),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final members = List<Map<String, dynamic>>.from(jsonResponse['data']);
        final filteredMembers =
            members.where((member) => member['graduation'] == 2027).toList();

        emit(MemberLoaded(filteredMembers));
      } else {
        emit(MemberError('Failed to fetch members'));
      }
    } catch (e) {
      print(e.toString());
      emit(MemberError(e.toString()));
    }
  }
}
