import 'package:bontempo/models/environment_model.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProjectCreateState extends Equatable {
  ProjectCreateState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedProjectCreateState extends ProjectCreateState {
  @override
  String toString() => 'UninitializedProjectCreateState';

  @override
  ProjectCreateState getStateCopy() {
    return UninitializedProjectCreateState();
  }
}

class LoadingEnvironmentsState extends ProjectCreateState {
  @override
  String toString() => 'LoadingEnvironmentsState';

  @override
  LoadingEnvironmentsState getStateCopy() {
    return LoadingEnvironmentsState();
  }
}

class LoadedEnvironmentsState extends ProjectCreateState {
  final List<EnvironmentModel> items;

  LoadedEnvironmentsState(this.items);

  LoadedEnvironmentsState copyWith({List<EnvironmentModel>? items}) {
    return LoadedEnvironmentsState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedEnvironmentsState { items: ${items.length} }';

  @override
  LoadedEnvironmentsState getStateCopy() {
    return LoadedEnvironmentsState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorEnvironmentsState extends ProjectCreateState {
  final String errorMessage;

  ErrorEnvironmentsState(this.errorMessage);

  @override
  String toString() => 'ErrorEnvironmentsState { $errorMessage }';

  @override
  ErrorEnvironmentsState getStateCopy() {
    return ErrorEnvironmentsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class CreatedProjectState extends ProjectCreateState {
  final ProjectModel model;

  CreatedProjectState(this.model);

  CreatedProjectState copyWith({ProjectModel? model}) {
    return CreatedProjectState(model ?? this.model);
  }

  @override
  String toString() => 'CreatedProjectState { model: $model }';

  @override
  CreatedProjectState getStateCopy() {
    return CreatedProjectState(this.model);
  }

  @override
  List<Object> get props => [model];
}

class ErrorCreateProjectState extends ProjectCreateState {
  final String errorMessage;

  ErrorCreateProjectState(this.errorMessage);

  @override
  String toString() => 'ErrorCreateProjectState { $errorMessage }';

  @override
  ErrorCreateProjectState getStateCopy() {
    return ErrorCreateProjectState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
