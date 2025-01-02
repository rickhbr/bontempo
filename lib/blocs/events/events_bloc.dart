import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/events/index.dart';
import 'package:bontempo/models/event_model.dart';
import 'package:bontempo/repositories/event_repository.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository repository = EventRepository();

  EventsBloc({EventsState? initialState})
      : super(initialState ?? UninitializedEventsState()) {
    on<CheckEventsPermissionEvent>(_onCheckEventsPermissionEvent);
    on<AuthorizeCalendarEvent>(_onAuthorizeCalendarEvent);
    on<LoadEventsEvent>(_onLoadEventsEvent);
  }

  Future<void> _onCheckEventsPermissionEvent(
      CheckEventsPermissionEvent event, Emitter<EventsState> emit) async {
    String? token = await repository.getCalendarToken();
    emit(CheckedPermissionState(valid: token != null));
  }

  Future<void> _onAuthorizeCalendarEvent(
      AuthorizeCalendarEvent event, Emitter<EventsState> emit) async {
    emit(CheckingPermissionState());
    String? token = await repository.authorizeCalendar();
    emit(CheckedPermissionState(valid: token != null));
  }

  Future<void> _onLoadEventsEvent(
      LoadEventsEvent event, Emitter<EventsState> emit) async {
    final currentState = state;
    if (currentState is! LoadingEventsState) {
      try {
        emit(LoadingEventsState());
        String? token = await repository.getCalendarToken();
        if (token != null) {
          List<EventModel> data =
              await repository.getDayEvents(event.date ?? '1');
          emit(LoadedEventsState(events: data));
        } else {
          emit(ErrorEventsState('Calendário não vinculado.'));
        }
      } catch (error) {
        emit(ErrorEventsState(error.toString()));
      }
    }
  }
}
