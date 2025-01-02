import 'package:equatable/equatable.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecipesState extends Equatable {
  RecipesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedRecipesState extends RecipesState {
  @override
  String toString() => 'UninitializedRecipesState';

  @override
  RecipesState getStateCopy() {
    return UninitializedRecipesState();
  }
}

class LoadingRecipesState extends RecipesState {
  @override
  String toString() => 'LoadingRecipesState';

  @override
  RecipesState getStateCopy() {
    return LoadingRecipesState();
  }
}

class LoadedRecipesState extends RecipesState {
  final List<RecipeModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedRecipesState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedRecipesState copyWith({
    List<RecipeModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedRecipesState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedRecipesState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  RecipesState getStateCopy() {
    return LoadedRecipesState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class ErrorRecipesState extends RecipesState {
  final String errorMessage;

  ErrorRecipesState(this.errorMessage);

  @override
  String toString() => 'ErrorRecipesState { $errorMessage }';

  @override
  RecipesState getStateCopy() {
    return ErrorRecipesState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class LoadingRecipeDetailsState extends RecipesState {
  @override
  String toString() => 'LoadingRecipeDetailsState';

  @override
  RecipesState getStateCopy() {
    return LoadingRecipeDetailsState();
  }
}

class LoadedRecipeDetailsState extends RecipesState {
  final RecipeModel recipe;

  LoadedRecipeDetailsState({required this.recipe});

  LoadedRecipeDetailsState copyWith({RecipeModel? recipe}) {
    return LoadedRecipeDetailsState(recipe: recipe ?? this.recipe);
  }

  @override
  String toString() => 'LoadedRecipeDetailsState { recipe: ${recipe.title} }';

  @override
  RecipesState getStateCopy() {
    return LoadedRecipeDetailsState(recipe: this.recipe);
  }

  @override
  List<Object> get props => [recipe];
}

class ErrorRecipeDetailsState extends RecipesState {
  final String errorMessage;

  ErrorRecipeDetailsState(this.errorMessage);

  @override
  String toString() => 'ErrorRecipeDetailsState { $errorMessage }';

  @override
  RecipesState getStateCopy() {
    return ErrorRecipeDetailsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class LoadingRecipeDoneState extends RecipesState {
  @override
  String toString() => 'LoadingRecipeDoneState';

  @override
  RecipesState getStateCopy() {
    return LoadingRecipeDoneState();
  }
}

class LoadedRecipeDoneState extends RecipesState {
  @override
  String toString() => 'LoadedRecipeDoneState';

  @override
  RecipesState getStateCopy() {
    return LoadedRecipeDoneState();
  }
}

class ErrorRecipeDoneState extends RecipesState {
  final String errorMessage;

  ErrorRecipeDoneState(this.errorMessage);

  @override
  String toString() => 'ErrorRecipeDoneState { $errorMessage }';

  @override
  RecipesState getStateCopy() {
    return ErrorRecipeDoneState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
