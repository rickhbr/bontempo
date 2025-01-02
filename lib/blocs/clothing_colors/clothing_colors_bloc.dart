import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing_colors/index.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/repositories/clothing_colors_repository.dart';

class ClothingColorsBloc
    extends Bloc<ClothingColorsEvent, ClothingColorsState> {
  final ClothingColorsRepository repository = ClothingColorsRepository();

  ClothingColorsBloc({ClothingColorsState? initialState})
      : super(initialState ?? UninitializedClothingColorsState()) {
    on<LoadClothingColorsEvent>(_onLoadClothingColorsEvent);
  }

  void _onLoadClothingColorsEvent(
      LoadClothingColorsEvent event, Emitter<ClothingColorsState> emit) async {
    final currentState = state;
    if (currentState is! LoadingClothingColorsState) {
      try {
        emit(LoadingClothingColorsState());
        List<ClothingColorModel> items = await repository.getClothingColors();
        emit(LoadedClothingColorsState(items: items));
      } catch (error) {
        emit(ErrorClothingColorsState(error.toString()));
      }
    }
  }
}
