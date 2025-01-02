import 'package:bontempo/models/project_create_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProjectCreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEnvironmentsEvent extends ProjectCreateEvent {
  LoadEnvironmentsEvent();

  @override
  String toString() => 'LoadEnvironmentsEvent';
}

class CreateProjectEvent extends ProjectCreateEvent {
  final ProjectCreateModel model;
  CreateProjectEvent(this.model);

  @override
  List<Object?> get props => [model];

  @override
  String toString() => 'CreateProjectEvent';
}
