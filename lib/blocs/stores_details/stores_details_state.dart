import 'package:bontempo/models/architects_model.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StoresDetailsState extends Equatable {
  StoresDetailsState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedStoresDetailsState extends StoresDetailsState {
  @override
  String toString() => 'UninitializedStoresDetailsState';

  @override
  StoresDetailsState getStateCopy() {
    return UninitializedStoresDetailsState();
  }
}

class LoadingArchitectsState extends StoresDetailsState {
  @override
  String toString() => 'LoadingArchitectsState';

  @override
  LoadingArchitectsState getStateCopy() {
    return LoadingArchitectsState();
  }
}

class LoadedArchitectsState extends StoresDetailsState {
  final List<ArchitectsModel> items;

  LoadedArchitectsState(this.items);

  LoadedArchitectsState copyWith({List<ArchitectsModel>? items}) {
    return LoadedArchitectsState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedArchitectsState';

  @override
  LoadedArchitectsState getStateCopy() {
    return LoadedArchitectsState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class LoadedProjectsState extends StoresDetailsState {
  final List<ProjectModel> items;

  LoadedProjectsState(this.items);

  LoadedProjectsState copyWith({List<ProjectModel>? items}) {
    return LoadedProjectsState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedProjectsState';

  @override
  LoadedProjectsState getStateCopy() {
    return LoadedProjectsState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorArchitectsState extends StoresDetailsState {
  final String errorMessage;

  ErrorArchitectsState(this.errorMessage);

  @override
  String toString() => 'ErrorArchitectsState { ${this.errorMessage} }';

  @override
  ErrorArchitectsState getStateCopy() {
    return ErrorArchitectsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class ErrorProjectsState extends StoresDetailsState {
  final String errorMessage;

  ErrorProjectsState(this.errorMessage);

  @override
  String toString() => 'ErrorProjectsState { ${this.errorMessage} }';

  @override
  ErrorProjectsState getStateCopy() {
    return ErrorProjectsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
