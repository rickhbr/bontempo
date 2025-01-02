import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/looks_schedule/index.dart';
import 'package:bontempo/models/look_calendar_model.dart';
import 'package:bontempo/models/look_schedule_model.dart';
import 'package:bontempo/repositories/look_schedule_repository.dart';

class LooksScheduleBloc extends Bloc<LooksScheduleEvent, LooksScheduleState> {
  final LooksScheduleRepository repository = LooksScheduleRepository();

  LooksScheduleBloc() : super(UninitializedLooksScheduleState()) {
    on<LoadLooksScheduleEvent>(_onLoadLooksScheduleEvent);
    on<LoadLooksScheduleDateEvent>(_onLoadLooksScheduleDateEvent);
    on<RemoveLooksScheduleEvent>(_onRemoveLooksScheduleEvent);
    on<AddLooksScheduleEvent>(_onAddLooksScheduleEvent);
  }

  Future<void> _onLoadLooksScheduleEvent(
      LoadLooksScheduleEvent event, Emitter<LooksScheduleState> emit) async {
    if (state is! LoadingLooksScheduleState) {
      try {
        emit(LoadingLooksScheduleState());
        List<LookCalendarModel> schedule = await repository.getCalendar();
        emit(LoadedLooksScheduleState(schedule: schedule));
      } catch (error) {
        emit(ErrorLooksScheduleState(error.toString()));
      }
    }
  }

  Future<void> _onLoadLooksScheduleDateEvent(LoadLooksScheduleDateEvent event,
      Emitter<LooksScheduleState> emit) async {
    if (state is! LoadingLooksScheduleState) {
      try {
        emit(LoadingLooksScheduleState());
        List<LookScheduleModel> looks = await repository.getByDate(event.date);
        emit(LoadedLooksDateState(looks: looks));
      } catch (error) {
        emit(ErrorLooksScheduleState(error.toString()));
      }
    }
  }

  Future<void> _onRemoveLooksScheduleEvent(
      RemoveLooksScheduleEvent event, Emitter<LooksScheduleState> emit) async {
    try {
      emit(RemovingLooksScheduleState());
      int idSchedule = await repository.deleteLookSchedule(event.idSchedule);
      emit(RemovedLooksScheduleState(idSchedule: idSchedule));
    } catch (error) {
      emit(ErrorLooksScheduleState(error.toString()));
    }
  }

  Future<void> _onAddLooksScheduleEvent(
      AddLooksScheduleEvent event, Emitter<LooksScheduleState> emit) async {
    try {
      emit(AddingLooksScheduleState());
      LookScheduleModel lookSchedule = await repository.addLookSchedule(
        date: event.date,
        idLook: event.idLook,
      );
      emit(AddedLooksScheduleState(lookSchedule: lookSchedule));
    } catch (error) {
      emit(ErrorLooksScheduleState(error.toString()));
    }
  }
}
