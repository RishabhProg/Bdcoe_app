abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Map<String, dynamic>> events;

  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}
