import 'package:equatable/equatable.dart';
import 'package:bontempo/models/event_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EventsState extends Equatable {
  EventsState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedEventsState extends EventsState {
  @override
  String toString() => 'UninitializedEventsState';

  @override
  EventsState getStateCopy() {
    return UninitializedEventsState();
  }
}

class LoadingEventsState extends EventsState {
  @override
  String toString() => 'LoadingEventsState';

  @override
  EventsState getStateCopy() {
    return LoadingEventsState();
  }
}

class CheckingPermissionState extends EventsState {
  @override
  String toString() => 'CheckingPermissionState';

  @override
  EventsState getStateCopy() {
    return CheckingPermissionState();
  }
}

class CheckedPermissionState extends EventsState {
  final bool valid;

  CheckedPermissionState({required this.valid});

  CheckedPermissionState copyWith({bool? valid}) {
    return CheckedPermissionState(
      valid: valid ?? this.valid,
    );
  }

  @override
  String toString() => 'CheckedPermissionState: { valid: $valid }';

  @override
  EventsState getStateCopy() {
    return CheckedPermissionState(valid: this.valid);
  }

  @override
  List<Object> get props => [valid];
}

class LoadedEventsState extends EventsState {
  final List<EventModel> events;

  LoadedEventsState({required this.events});

  LoadedEventsState copyWith({List<EventModel>? events}) {
    return LoadedEventsState(
      events: events ?? this.events,
    );
  }

  @override
  String toString() => 'LoadedEventsState { events: ${events.length} }';

  @override
  EventsState getStateCopy() {
    return LoadedEventsState(events: this.events);
  }

  @override
  List<Object> get props => [events];
}

class ErrorEventsState extends EventsState {
  final String errorMessage;

  ErrorEventsState(this.errorMessage);

  @override
  String toString() => 'ErrorEventsState { $errorMessage }';

  @override
  EventsState getStateCopy() {
    return ErrorEventsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
