import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadEventsEvent extends EventsEvent {
  final String? date;
  LoadEventsEvent({this.date});

  @override
  String toString() => 'LoadEventsEvent: { date: $date }';
}

class CheckEventsPermissionEvent extends EventsEvent {
  CheckEventsPermissionEvent();

  @override
  String toString() => 'CheckEventsPermissionEvent';
}

class AuthorizeCalendarEvent extends EventsEvent {
  AuthorizeCalendarEvent();

  @override
  String toString() => 'AuthorizeCalendarEvent';
}
