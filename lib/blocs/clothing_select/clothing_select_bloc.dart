import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing_select/index.dart';
import 'package:bontempo/models/clothing_model.dart';

class ClothingSelectBloc
    extends Bloc<ClothingSelectEvent, ClothingSelectState> {
  ClothingSelectBloc({ClothingSelectState? initialState})
      : super(initialState ?? UninitializedClothingSelectState()) {
    on<SetSelectClothingEvent>(_onSetSelectClothingEvent);
    on<SelectClothingEvent>(_onSelectClothingEvent);
    on<UnselectClothingEvent>(_onUnselectClothingEvent);
  }

  void _onSetSelectClothingEvent(
      SetSelectClothingEvent event, Emitter<ClothingSelectState> emit) {
    emit(SelectedClothingSelectState(event.items));
  }

  void _onSelectClothingEvent(
      SelectClothingEvent event, Emitter<ClothingSelectState> emit) {
    final currentState = state;
    List<ClothingModel> items = [];
    if (currentState is SelectedClothingSelectState) {
      items = List.from(currentState.items);
    }
    if (event.item.isMain) {
      items.removeWhere((ClothingModel clothing) =>
          clothing.isMain &&
          clothing.placements
              .any((place) => event.item.placements.contains(place)));
    }
    items.add(event.item);
    emit(SelectedClothingSelectState(items));
  }

  void _onUnselectClothingEvent(
      UnselectClothingEvent event, Emitter<ClothingSelectState> emit) {
    final currentState = state;
    List<ClothingModel> items = [];
    if (currentState is SelectedClothingSelectState) {
      items = List.from(currentState.items);
    }
    items.removeWhere((ClothingModel clothing) => event.item.id == clothing.id);
    emit(SelectedClothingSelectState(items));
  }
}
