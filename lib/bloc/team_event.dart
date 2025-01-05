import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();
  @override
  List<Object?> get props => [];
}

class FetchMembers extends MemberEvent {
  final int year;

 const FetchMembers(this.year);
  @override
  List<Object?> get props => [year];
}
class Dropdownchangedevent extends MemberEvent {
  final String newValue;

 const Dropdownchangedevent(this.newValue);
  @override
  List<Object?> get props => [newValue];
}
