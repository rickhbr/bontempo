import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bontempo/models/news_category_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsCategoriesState extends Equatable {
  NewsCategoriesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedNewsCategoriesState extends NewsCategoriesState {
  @override
  String toString() => 'UninitializedNewsCategoriesState';

  @override
  NewsCategoriesState getStateCopy() {
    return UninitializedNewsCategoriesState();
  }
}

class LoadingNewsCategoriesState extends NewsCategoriesState {
  @override
  String toString() => 'LoadingNewsCategoriesState';

  @override
  NewsCategoriesState getStateCopy() {
    return LoadingNewsCategoriesState();
  }
}

class LoadedNewsCategoriesState extends NewsCategoriesState {
  final List<NewsCategoryModel> items;

  LoadedNewsCategoriesState(this.items);

  LoadedNewsCategoriesState copyWith({
    List<NewsCategoryModel>? items,
  }) {
    return LoadedNewsCategoriesState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedNewsCategoriesState { items: ${items.length} }';

  @override
  NewsCategoriesState getStateCopy() {
    return LoadedNewsCategoriesState(this.items);
  }
}

class SavingNewsCategoriesState extends NewsCategoriesState {
  @override
  String toString() => 'SavingNewsCategoriesState';

  @override
  NewsCategoriesState getStateCopy() {
    return SavingNewsCategoriesState();
  }
}

class SavedNewsCategoriesState extends NewsCategoriesState {
  final Map<String, dynamic> response;

  SavedNewsCategoriesState(this.response);

  @override
  String toString() =>
      'SavedNewsCategoriesState { response: ${jsonEncode(this.response)} }';

  @override
  NewsCategoriesState getStateCopy() {
    return SavedNewsCategoriesState(this.response);
  }
}

class LoadingClientNewsCategoriesState extends NewsCategoriesState {
  @override
  String toString() => 'LoadingClientNewsCategoriesState';

  @override
  NewsCategoriesState getStateCopy() {
    return LoadingClientNewsCategoriesState();
  }
}

class LoadedClientNewsCategoriesState extends NewsCategoriesState {
  final List<NewsCategoryModel> items;

  LoadedClientNewsCategoriesState(this.items);

  LoadedClientNewsCategoriesState copyWith({
    List<NewsCategoryModel>? items,
  }) {
    return LoadedClientNewsCategoriesState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedNewsCategoriesState { items: ${items.length} }';

  @override
  NewsCategoriesState getStateCopy() {
    return LoadedNewsCategoriesState(this.items);
  }
}

class ErrorNewsCategoriesState extends NewsCategoriesState {
  final String errorMessage;

  ErrorNewsCategoriesState(this.errorMessage);

  @override
  String toString() => 'ErrorNewsCategoriesState { ${this.errorMessage} }';

  @override
  NewsCategoriesState getStateCopy() {
    return ErrorNewsCategoriesState(this.errorMessage);
  }
}

class CheckedNewsCategoriesState extends NewsCategoriesState {
  final bool selected;

  CheckedNewsCategoriesState(this.selected);

  @override
  String toString() => 'CheckedNewsCategoriesState { valid: ${this.selected} }';

  @override
  NewsCategoriesState getStateCopy() {
    return CheckedNewsCategoriesState(this.selected);
  }
}
