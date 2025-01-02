import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/stores_details/stores_details_event.dart';
import 'package:bontempo/blocs/stores_details/stores_details_state.dart';
import 'package:bontempo/repositories/project_repository.dart';
import 'package:bontempo/repositories/user_repository.dart';

class StoresDetailsBloc extends Bloc<StoresDetailsEvent, StoresDetailsState> {
  StoresDetailsBloc() : super(UninitializedStoresDetailsState()) {
    on<LoadArchitectsEvent>(_onLoadArchitectsEvent);
    on<LoadProjectsEvent>(_onLoadProjectsEvent);
  }

  Future<void> _onLoadArchitectsEvent(
      LoadArchitectsEvent event, Emitter<StoresDetailsState> emit) async {
    try {
      ProjectRepository repository = ProjectRepository();
      emit(LoadingArchitectsState());
      var store = await repository.architects();
      emit(LoadedArchitectsState(store['items']));
    } catch (error) {
      emit(ErrorArchitectsState(error.toString()));
    }
  }

  Future<void> _onLoadProjectsEvent(
      LoadProjectsEvent event, Emitter<StoresDetailsState> emit) async {
    try {
      ProjectRepository repository = ProjectRepository();
      UserRepository userRepository = UserRepository();
      var user = await userRepository.getUser();
      var store =
          await repository.getProjects(store: event.storeId, user: user.id);
      emit(LoadedProjectsState(store['items']));
    } catch (error) {
      emit(ErrorProjectsState(error.toString()));
    }
  }
}
