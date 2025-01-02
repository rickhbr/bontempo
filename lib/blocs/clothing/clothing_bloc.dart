import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/repositories/clothing_repository.dart';

class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  final ClothingRepository repository = ClothingRepository();

  ClothingBloc({ClothingState? initialState})
      : super(initialState ?? UninitializedClothingState()) {
    on<EditClothingEvent>(_onEditClothingEvent);
    on<RemoveClothingEvent>(_onRemoveClothingEvent);
    on<LoadClothingEvent>(_onLoadClothingEvent);
    on<LoadAllClothingEvent>(_onLoadAllClothingEvent);
    on<ResetClothingEvent>(_onResetClothingEvent);
  }

  void _onEditClothingEvent(
      EditClothingEvent event, Emitter<ClothingState> emit) async {
    try {
      emit(EditingClothingState());
      ClothingModel response =
          await repository.editClothing(event.idClothing!, event.data!);
      emit(EditedClothingState(response));
    } catch (error) {
      emit(ErrorClothingState(error.toString()));
    }
  }

  void _onRemoveClothingEvent(
      RemoveClothingEvent event, Emitter<ClothingState> emit) async {
    try {
      emit(RemovingClothingState());
      int idClothing = await repository.deleteClothing(event.idClothing);
      emit(RemovedClothingState(idClothing));
    } catch (error) {
      emit(ErrorClothingState(error.toString()));
    }
  }

  void _onLoadClothingEvent(
      LoadClothingEvent event, Emitter<ClothingState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) &&
        currentState is! LoadingClothingState) {
      try {
        if (currentState is UninitializedClothingState) {
          emit(LoadingClothingState());
          Map<String, dynamic> data = await repository.getClothes(
            page: 1,
          );
          emit(LoadedClothingState(
            items: List<ClothingModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else {
          var state = currentState as LoadedClothingState;
          emit(LoadingClothingState());
          Map<String, dynamic> data = await repository.getClothes(
            page: state.page! + 1,
          );

          List<ClothingModel> items = List<ClothingModel>.from(data['items']);
          emit(items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedClothingState(
                  items: items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorClothingState(error.toString()));
      }
    }
  }

  void _onLoadAllClothingEvent(
      LoadAllClothingEvent event, Emitter<ClothingState> emit) async {
    final currentState = state;
    if (currentState is! LoadingClothingState) {
      try {
        emit(LoadingClothingState());
        List<ClothingModel> data = await repository.getAllClothes(
          categoryId: event.categoryId!,
          colorId: event.colorId!,
        );
        print('Loaded items: $data'); // Log the loaded items
        emit(LoadedAllClothingState(items: data));
      } catch (error) {
        print('Error: $error'); // Log the error
        emit(ErrorClothingState(error.toString()));
      }
    }
  }

  void _onResetClothingEvent(
      ResetClothingEvent event, Emitter<ClothingState> emit) {
    emit(UninitializedClothingState());
  }

  bool _hasReachedMax(ClothingState state) =>
      state is LoadedClothingState && state.hasReachedMax!;
}
