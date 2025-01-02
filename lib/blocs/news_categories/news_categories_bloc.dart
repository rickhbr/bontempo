import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/news_categories/index.dart';
import 'package:bontempo/models/news_category_model.dart';
import 'package:bontempo/repositories/news_categories_repository.dart';

class NewsCategoriesBloc
    extends Bloc<NewsCategoriesEvent, NewsCategoriesState> {
  NewsCategoriesBloc() : super(UninitializedNewsCategoriesState()) {
    on<LoadNewsCategoriesEvent>(_onLoadNewsCategoriesEvent);
    on<SaveNewsCategoriesEvent>(_onSaveNewsCategoriesEvent);
    on<LoadClientNewsCategoriesEvent>(_onLoadClientNewsCategoriesEvent);
    on<CheckNewsCategoriesEvent>(_onCheckNewsCategoriesEvent);
  }

  Future<void> _onLoadNewsCategoriesEvent(
    LoadNewsCategoriesEvent event,
    Emitter<NewsCategoriesState> emit,
  ) async {
    try {
      emit(LoadingNewsCategoriesState());
      NewsCategoriesRepository repository = NewsCategoriesRepository();
      List<NewsCategoryModel> items = await repository.getNewsCategories();
      emit(LoadedNewsCategoriesState(items));
    } catch (error) {
      emit(ErrorNewsCategoriesState(error.toString()));
    }
  }

  Future<void> _onSaveNewsCategoriesEvent(
    SaveNewsCategoriesEvent event,
    Emitter<NewsCategoriesState> emit,
  ) async {
    try {
      emit(SavingNewsCategoriesState());
      NewsCategoriesRepository repository = NewsCategoriesRepository();
      Map<String, dynamic> response =
          await repository.saveNewsCategories(event.ids);
      emit(SavedNewsCategoriesState(response));
    } catch (error) {
      emit(ErrorNewsCategoriesState(error.toString()));
    }
  }

  Future<void> _onLoadClientNewsCategoriesEvent(
    LoadClientNewsCategoriesEvent event,
    Emitter<NewsCategoriesState> emit,
  ) async {
    try {
      emit(LoadingClientNewsCategoriesState());
      NewsCategoriesRepository repository = NewsCategoriesRepository();
      List<NewsCategoryModel> items =
          await repository.getClientNewsCategories();
      emit(LoadedClientNewsCategoriesState(items));
    } catch (error) {
      emit(ErrorNewsCategoriesState(error.toString()));
    }
  }

  Future<void> _onCheckNewsCategoriesEvent(
    CheckNewsCategoriesEvent event,
    Emitter<NewsCategoriesState> emit,
  ) async {
    try {
      emit(SavingNewsCategoriesState());
      NewsCategoriesRepository repository = NewsCategoriesRepository();
      bool check = await repository.checkSelected();
      emit(CheckedNewsCategoriesState(check));
    } catch (error) {
      emit(ErrorNewsCategoriesState(error.toString()));
    }
  }
}
