import 'package:bontempo/models/clothing_category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingCategoriesState extends Equatable {
  ClothingCategoriesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingCategoriesState extends ClothingCategoriesState {
  @override
  String toString() => 'UninitializedClothingCategoriesState';

  @override
  ClothingCategoriesState getStateCopy() {
    return UninitializedClothingCategoriesState();
  }
}

class LoadingClothingCategoriesState extends ClothingCategoriesState {
  @override
  String toString() => 'LoadingClothingCategoriesState';

  @override
  ClothingCategoriesState getStateCopy() {
    return LoadingClothingCategoriesState();
  }
}

class LoadedClothingCategoriesState extends ClothingCategoriesState {
  final List<ClothingCategoryModel> items;

  LoadedClothingCategoriesState({required this.items});

  LoadedClothingCategoriesState copyWith({
    List<ClothingCategoryModel>? items,
  }) {
    return LoadedClothingCategoriesState(
      items: items ?? this.items,
    );
  }

  @override
  String toString() =>
      'LoadedClothingCategoriesState { items: ${items.length} }';

  @override
  ClothingCategoriesState getStateCopy() {
    return LoadedClothingCategoriesState(items: this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorClothingCategoriesState extends ClothingCategoriesState {
  final String errorMessage;

  ErrorClothingCategoriesState(this.errorMessage);

  @override
  String toString() => 'ErrorClothingCategoriesState { ${this.errorMessage} }';

  @override
  ClothingCategoriesState getStateCopy() {
    return ErrorClothingCategoriesState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
