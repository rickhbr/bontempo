import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing_add/index.dart';
import 'package:bontempo/repositories/clothing_repository.dart';

class ClothingAddBloc extends Bloc<ClothingAddEvent, ClothingAddState> {
  final ClothingRepository repository = ClothingRepository();

  ClothingAddBloc({ClothingAddState? initialState})
      : super(initialState ?? UninitializedClothingAddState()) {
    on<AddClothingEvent>(_onAddClothingEvent);
  }

  void _onAddClothingEvent(
      AddClothingEvent event, Emitter<ClothingAddState> emit) async {
    try {
      emit(SendingClothingAddState());
      Map<String, dynamic> response = await repository.addClothing(event.data);
      emit(SentClothingAddState(response));
    } catch (error) {
      emit(ErrorClothingAddState(error.toString()));
    }
  }
}
