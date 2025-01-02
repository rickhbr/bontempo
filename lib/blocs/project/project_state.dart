import 'package:bontempo/models/architects_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProjectState extends Equatable {
  ProjectState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedProjectState extends ProjectState {
  @override
  String toString() => 'UninitializedProjectState';

  @override
  ProjectState getStateCopy() {
    return UninitializedProjectState();
  }
}

class LoadingArchitectsState extends ProjectState {
  @override
  String toString() => 'LoadingArchitectsState';

  @override
  LoadingArchitectsState getStateCopy() {
    return LoadingArchitectsState();
  }
}

class LoadedArchitectsState extends ProjectState {
  final List<ArchitectsModel> items;

  LoadedArchitectsState(this.items);

  LoadedArchitectsState copyWith({List<ArchitectsModel>? items}) {
    return LoadedArchitectsState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedArchitectsState { items: ${items.length} }';

  @override
  LoadedArchitectsState getStateCopy() {
    return LoadedArchitectsState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorArchitectsState extends ProjectState {
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
