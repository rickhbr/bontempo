import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/recipes/index.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/repositories/recipes_repository.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final RecipesRepository repository = RecipesRepository();

  RecipesBloc() : super(UninitializedRecipesState()) {
    on<LoadRecipesEvent>(_onLoadRecipesEvent);
    on<LoadRecipeDetailsEvent>(_onLoadRecipeDetailsEvent);
    on<RecipeDoneEvent>(_onRecipeDoneEvent);
    on<ResetRecipesEvent>(_onResetRecipesEvent);
  }

  Future<void> _onLoadRecipesEvent(
      LoadRecipesEvent event, Emitter<RecipesState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingRecipesState) {
      try {
        if (currentState is UninitializedRecipesState) {
          emit(LoadingRecipesState());
          Map<String, dynamic> data = await repository.getRecipes(
            page: 1,
            idType: event.idType,
            stockOnly: event.stockOnly ?? false,
          );
          emit(LoadedRecipesState(
            items: List<RecipeModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else {
          var state = currentState as LoadedRecipesState;
          emit(LoadingRecipesState());
          Map<String, dynamic> data = await repository.getRecipes(
            page: state.page! + 1,
            idType: event.idType,
            stockOnly: event.stockOnly ?? false,
          );

          List<RecipeModel> items = List<RecipeModel>.from(data['items']);
          emit(items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedRecipesState(
                  items: state.items! + items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorRecipesState(error.toString()));
      }
    }
  }

  Future<void> _onLoadRecipeDetailsEvent(
      LoadRecipeDetailsEvent event, Emitter<RecipesState> emit) async {
    try {
      emit(LoadingRecipeDetailsState());
      RecipeModel data = await repository.getRecipeDetails(
        id: event.id,
      );
      emit(LoadedRecipeDetailsState(recipe: data));
    } catch (error) {
      emit(ErrorRecipeDetailsState(error.toString()));
    }
  }

  Future<void> _onRecipeDoneEvent(
      RecipeDoneEvent event, Emitter<RecipesState> emit) async {
    try {
      emit(LoadingRecipeDoneState());
      await repository.markAsDone(
        id: event.id,
      );
      emit(LoadedRecipeDoneState());
    } catch (error) {
      emit(ErrorRecipeDoneState(error.toString()));
    }
  }

  void _onResetRecipesEvent(
      ResetRecipesEvent event, Emitter<RecipesState> emit) {
    emit(UninitializedRecipesState());
  }

  bool _hasReachedMax(RecipesState state) =>
      state is LoadedRecipesState && state.hasReachedMax!;
}
