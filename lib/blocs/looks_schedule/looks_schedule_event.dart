import 'package:equatable/equatable.dart';

abstract class LooksScheduleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLooksScheduleEvent extends LooksScheduleEvent {
  LoadLooksScheduleEvent();

  @override
  String toString() => 'LoadLooksScheduleEvent';
}

class LoadLooksScheduleDateEvent extends LooksScheduleEvent {
  final String date;
  LoadLooksScheduleDateEvent(this.date);

  @override
  String toString() => 'LoadLooksScheduleDateEvent { date: $date }';
}

class RemoveLooksScheduleEvent extends LooksScheduleEvent {
  final int idSchedule;
  RemoveLooksScheduleEvent(this.idSchedule);

  @override
  String toString() => 'RemoveLooksScheduleEvent { id: $idSchedule }';
}

class AddLooksScheduleEvent extends LooksScheduleEvent {
  final int? idLook;
  final String? date;
  AddLooksScheduleEvent({this.idLook, this.date});

  @override
  String toString() => 'AddLooksScheduleEvent { idLook: $idLook, date: $date }';
}
