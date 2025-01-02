import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final List<Map<String, dynamic>> members;

  MemberLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class MemberError extends MemberState {
  final String error;

  MemberError(this.error);

  @override
  List<Object?> get props => [error];
}
