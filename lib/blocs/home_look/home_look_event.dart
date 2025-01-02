import 'package:equatable/equatable.dart';

abstract class HomeLookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SkipHomeLookEvent extends HomeLookEvent {
  SkipHomeLookEvent();

  @override
  String toString() => 'SkipHomeLookEvent';
}

class SaveHomeLookEvent extends HomeLookEvent {
  final Map<String, dynamic> data;
  SaveHomeLookEvent(this.data);

  @override
  String toString() => 'SaveHomeLookEvent';
}
