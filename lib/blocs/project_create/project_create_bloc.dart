import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/project_create/project_create_event.dart';
import 'package:bontempo/blocs/project_create/project_create_state.dart';
import 'package:bontempo/repositories/project_repository.dart';
import 'package:bontempo/repositories/user_repository.dart';

class ProjectCreateBloc extends Bloc<ProjectCreateEvent, ProjectCreateState> {
  ProjectCreateBloc() : super(UninitializedProjectCreateState()) {
    on<LoadEnvironmentsEvent>(_onLoadEnvironmentsEvent);
    on<CreateProjectEvent>(_onCreateProjectEvent);
  }

  Future<void> _onLoadEnvironmentsEvent(
      LoadEnvironmentsEvent event, Emitter<ProjectCreateState> emit) async {
    try {
      ProjectRepository repository = ProjectRepository();
      emit(LoadingEnvironmentsState());
      var store = await repository.environments();
      emit(LoadedEnvironmentsState(store['items']));
    } catch (error) {
      emit(ErrorEnvironmentsState(error.toString()));
    }
  }

  Future<void> _onCreateProjectEvent(
      CreateProjectEvent event, Emitter<ProjectCreateState> emit) async {
    try {
      UserRepository userRepository = UserRepository();
      ProjectRepository repository = ProjectRepository();

      var user = await userRepository.getUser();
      event.model.userId = user.id;

      String jsonData = jsonEncode(event.model.toJson());
      _printLongString('Criando projeto com o modelo: $jsonData');

      var store = await repository.create(event.model);
      print('Projeto criado com sucesso: ${jsonEncode(store.toJson())}');
      emit(CreatedProjectState(store));
    } catch (error) {
      print('Erro ao criar o projeto: $error');
      emit(ErrorCreateProjectState(error.toString()));
    }
  }

  void _printLongString(String str) {
    const int chunkSize = 800;
    int startIndex = 0;
    while (startIndex < str.length) {
      int endIndex = startIndex + chunkSize;
      if (endIndex > str.length) endIndex = str.length;
      print(str.substring(startIndex, endIndex));
      startIndex = endIndex;
    }
  }
}
