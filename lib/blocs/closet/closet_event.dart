import 'package:equatable/equatable.dart';

abstract class ClosetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadClosetEvent extends ClosetEvent {
  LoadClosetEvent();

  @override
  String toString() => 'LoadClosetEvent';
}
