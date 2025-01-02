import 'package:equatable/equatable.dart';

abstract class ClimatesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadClimatesEvent extends ClimatesEvent {
  LoadClimatesEvent();

  @override
  String toString() => 'LoadClimatesEvent';
}
