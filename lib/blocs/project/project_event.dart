import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadArchitectsEvent extends ProjectEvent {
  LoadArchitectsEvent();

  @override
  String toString() => 'LoadArchitectsEvent';
}
