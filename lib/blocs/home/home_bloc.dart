import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/home/index.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/repositories/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(UninitializedHomeState()) {
    on<LoadHomeEvent>(_onLoadHomeEvent);
  }

  Future<void> _onLoadHomeEvent(
    LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(LoadingHomeState());
      HomeRepository repository = HomeRepository();
      HomeModel home = await repository.getHome();
      emit(LoadedHomeState(home));
    } catch (error) {
      emit(ErrorHomeState(error.toString()));
    }
  }
}
