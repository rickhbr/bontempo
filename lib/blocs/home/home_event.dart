import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHomeEvent extends HomeEvent {
  LoadHomeEvent();

  @override
  String toString() => 'LoadHomeEvent';
}
