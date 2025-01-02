import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/project/project_event.dart';
import 'package:bontempo/blocs/project/project_state.dart';
import 'package:bontempo/repositories/project_repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(UninitializedProjectState());

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadArchitectsEvent &&
        currentState is! LoadingArchitectsState) {
      try {
        ProjectRepository repository = ProjectRepository();

        yield LoadingArchitectsState();

        var store = await repository.architects();
        yield LoadedArchitectsState(store['items']);
      } catch (error) {
        yield ErrorArchitectsState(error.toString());
      }
    }
  }
}
