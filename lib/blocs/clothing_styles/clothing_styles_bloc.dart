import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing_styles/index.dart';
import 'package:bontempo/models/clothing_style_model.dart';
import 'package:bontempo/repositories/clothing_styles_repository.dart';

class ClothingStylesBloc
    extends Bloc<ClothingStylesEvent, ClothingStylesState> {
  final ClothingStylesRepository repository = ClothingStylesRepository();

  ClothingStylesBloc({ClothingStylesState? initialState})
      : super(initialState ?? UninitializedClothingStylesState()) {
    on<LoadClothingStylesEvent>(_onLoadClothingStylesEvent);
  }

  void _onLoadClothingStylesEvent(
      LoadClothingStylesEvent event, Emitter<ClothingStylesState> emit) async {
    if (state is! LoadingClothingStylesState) {
      try {
        emit(LoadingClothingStylesState());
        List<ClothingStyleModel> items = await repository.getClothingStyles();
        emit(LoadedClothingStylesState(items: items));
      } catch (error) {
        emit(ErrorClothingStylesState(error.toString()));
      }
    }
  }
}
