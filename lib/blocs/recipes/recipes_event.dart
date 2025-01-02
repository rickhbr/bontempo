import 'package:equatable/equatable.dart';

abstract class RecipesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRecipesEvent extends RecipesEvent {
  final int? idType;
  final bool? stockOnly;
  LoadRecipesEvent({this.idType, this.stockOnly});

  @override
  String toString() =>
      'LoadRecipesEvent: { idGastronomyType: $idType, stockOnly: $stockOnly }';
}

class LoadRecipeDetailsEvent extends RecipesEvent {
  final int? id;
  LoadRecipeDetailsEvent({this.id});

  @override
  String toString() => 'LoadRecipeDetailsEvent: { id: $id }';
}

class RecipeDoneEvent extends RecipesEvent {
  final int? id;
  RecipeDoneEvent({this.id});

  @override
  String toString() => 'RecipeDoneEvent: { id: $id }';
}

class ResetRecipesEvent extends RecipesEvent {
  @override
  String toString() => 'ResetRecipesEvent';
}
