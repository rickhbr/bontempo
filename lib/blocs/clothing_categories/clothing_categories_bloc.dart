import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/clothing_categories/index.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/repositories/clothing_categories_repository.dart';

class ClothingCategoriesBloc
    extends Bloc<ClothingCategoriesEvent, ClothingCategoriesState> {
  final ClothingCategoriesRepository repository =
      ClothingCategoriesRepository();

  ClothingCategoriesBloc({ClothingCategoriesState? initialState})
      : super(initialState ?? UninitializedClothingCategoriesState()) {
    on<LoadClothingCategoriesEvent>(_onLoadClothingCategoriesEvent);
  }

  void _onLoadClothingCategoriesEvent(LoadClothingCategoriesEvent event,
      Emitter<ClothingCategoriesState> emit) async {
    if (state is! LoadingClothingCategoriesState) {
      try {
        emit(LoadingClothingCategoriesState());
        List<ClothingCategoryModel> items =
            await repository.getClothingCategories();
        emit(LoadedClothingCategoriesState(items: items));
      } catch (error) {
        emit(ErrorClothingCategoriesState(error.toString()));
      }
    }
  }
}
