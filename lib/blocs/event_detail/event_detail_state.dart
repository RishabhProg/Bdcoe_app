import 'package:equatable/equatable.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Map<String, dynamic>> events;

  const EventLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object?> get props => [message];
}