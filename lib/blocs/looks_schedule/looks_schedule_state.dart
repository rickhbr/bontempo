import 'package:bontempo/models/look_calendar_model.dart';
import 'package:bontempo/models/look_schedule_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LooksScheduleState extends Equatable {
  LooksScheduleState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedLooksScheduleState extends LooksScheduleState {
  @override
  String toString() => 'UninitializedLooksScheduleState';

  @override
  LooksScheduleState getStateCopy() {
    return UninitializedLooksScheduleState();
  }
}

class LoadingLooksScheduleState extends LooksScheduleState {
  @override
  String toString() => 'LoadingLooksScheduleState';

  @override
  LooksScheduleState getStateCopy() {
    return LoadingLooksScheduleState();
  }
}

class LoadedLooksScheduleState extends LooksScheduleState {
  final List<LookCalendarModel> schedule;

  LoadedLooksScheduleState({required this.schedule});

  LoadedLooksScheduleState copyWith({List<LookCalendarModel>? schedule}) {
    return LoadedLooksScheduleState(schedule: schedule ?? this.schedule);
  }

  @override
  String toString() =>
      'LoadedLooksScheduleState { schedule: ${schedule.length} }';

  @override
  LooksScheduleState getStateCopy() {
    return LoadedLooksScheduleState(schedule: this.schedule);
  }

  @override
  List<Object> get props => [schedule];
}

class LoadedLooksDateState extends LooksScheduleState {
  final List<LookScheduleModel> looks;

  LoadedLooksDateState({required this.looks});

  LoadedLooksDateState copyWith({List<LookScheduleModel>? looks}) {
    return LoadedLooksDateState(looks: looks ?? this.looks);
  }

  @override
  String toString() => 'LoadedLooksDateState { looks: ${looks.length} }';

  @override
  LooksScheduleState getStateCopy() {
    return LoadedLooksDateState(looks: this.looks);
  }

  @override
  List<Object> get props => [looks];
}

class RemovingLooksScheduleState extends LooksScheduleState {
  @override
  String toString() => 'RemovingLooksScheduleState';

  @override
  LooksScheduleState getStateCopy() {
    return RemovingLooksScheduleState();
  }
}

class RemovedLooksScheduleState extends LooksScheduleState {
  final int idSchedule;

  RemovedLooksScheduleState({required this.idSchedule});

  RemovedLooksScheduleState copyWith({int? idSchedule}) {
    return RemovedLooksScheduleState(idSchedule: idSchedule ?? this.idSchedule);
  }

  @override
  String toString() => 'RemovedLooksScheduleState { idSchedule: $idSchedule }';

  @override
  LooksScheduleState getStateCopy() {
    return RemovedLooksScheduleState(idSchedule: this.idSchedule);
  }

  @override
  List<Object> get props => [idSchedule];
}

class AddingLooksScheduleState extends LooksScheduleState {
  @override
  String toString() => 'AddingLooksScheduleState';

  @override
  LooksScheduleState getStateCopy() {
    return AddingLooksScheduleState();
  }
}

class AddedLooksScheduleState extends LooksScheduleState {
  final LookScheduleModel lookSchedule;

  AddedLooksScheduleState({required this.lookSchedule});

  AddedLooksScheduleState copyWith({LookScheduleModel? lookSchedule}) {
    return AddedLooksScheduleState(
        lookSchedule: lookSchedule ?? this.lookSchedule);
  }

  @override
  String toString() =>
      'AddedLooksScheduleState { lookSchedule: $lookSchedule }';

  @override
  LooksScheduleState getStateCopy() {
    return AddedLooksScheduleState(lookSchedule: this.lookSchedule);
  }

  @override
  List<Object> get props => [lookSchedule];
}

class ErrorLooksScheduleState extends LooksScheduleState {
  final String errorMessage;

  ErrorLooksScheduleState(this.errorMessage);

  @override
  String toString() => 'ErrorLooksScheduleState { ${this.errorMessage} }';

  @override
  LooksScheduleState getStateCopy() {
    return ErrorLooksScheduleState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
