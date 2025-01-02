import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/gastronomy_types/index.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/repositories/gastronomy_types_repository.dart';

class GastronomyTypesBloc
    extends Bloc<GastronomyTypesEvent, GastronomyTypesState> {
  GastronomyTypesBloc() : super(UninitializedGastronomyTypesState()) {
    on<LoadGastronomyTypesEvent>(_onLoadGastronomyTypesEvent);
    on<SaveGastronomyTypesEvent>(_onSaveGastronomyTypesEvent);
    on<LoadClientGastronomyTypesEvent>(_onLoadClientGastronomyTypesEvent);
    on<CheckGastronomyTypesEvent>(_onCheckGastronomyTypesEvent);
  }

  Future<void> _onLoadGastronomyTypesEvent(
    LoadGastronomyTypesEvent event,
    Emitter<GastronomyTypesState> emit,
  ) async {
    try {
      emit(LoadingGastronomyTypesState());
      GastronomyTypesRepository repository = GastronomyTypesRepository();
      List<GastronomyTypeModel> items = await repository.getGastronomyTypes();
      emit(LoadedGastronomyTypesState(items));
    } catch (error) {
      emit(ErrorGastronomyTypesState(error.toString()));
    }
  }

  Future<void> _onSaveGastronomyTypesEvent(
    SaveGastronomyTypesEvent event,
    Emitter<GastronomyTypesState> emit,
  ) async {
    try {
      emit(SavingGastronomyTypesState());
      GastronomyTypesRepository repository = GastronomyTypesRepository();
      Map<String, dynamic> response =
          await repository.saveGastronomyTypes(event.ids);
      emit(SavedGastronomyTypesState(response));
    } catch (error) {
      emit(ErrorGastronomyTypesState(error.toString()));
    }
  }

  Future<void> _onLoadClientGastronomyTypesEvent(
    LoadClientGastronomyTypesEvent event,
    Emitter<GastronomyTypesState> emit,
  ) async {
    try {
      emit(LoadingClientGastronomyTypesState());
      GastronomyTypesRepository repository = GastronomyTypesRepository();
      List<GastronomyTypeModel> items =
          await repository.getClientGastronomyTypes();
      emit(LoadedClientGastronomyTypesState(items));
    } catch (error) {
      emit(ErrorGastronomyTypesState(error.toString()));
    }
  }

  Future<void> _onCheckGastronomyTypesEvent(
    CheckGastronomyTypesEvent event,
    Emitter<GastronomyTypesState> emit,
  ) async {
    try {
      emit(SavingGastronomyTypesState());
      GastronomyTypesRepository repository = GastronomyTypesRepository();
      bool check = await repository.checkSelected();
      emit(CheckedGastronomyTypesState(check));
    } catch (error) {
      emit(ErrorGastronomyTypesState(error.toString()));
    }
  }
}
