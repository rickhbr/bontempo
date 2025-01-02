import 'package:bontempo/models/clothing_style_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingStylesState extends Equatable {
  ClothingStylesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingStylesState extends ClothingStylesState {
  @override
  String toString() => 'UninitializedClothingStylesState';

  @override
  ClothingStylesState getStateCopy() {
    return UninitializedClothingStylesState();
  }
}

class LoadingClothingStylesState extends ClothingStylesState {
  @override
  String toString() => 'LoadingClothingStylesState';

  @override
  ClothingStylesState getStateCopy() {
    return LoadingClothingStylesState();
  }
}

class LoadedClothingStylesState extends ClothingStylesState {
  final List<ClothingStyleModel> items;

  LoadedClothingStylesState({required this.items});

  LoadedClothingStylesState copyWith({
    List<ClothingStyleModel>? items,
  }) {
    return LoadedClothingStylesState(
      items: items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedClothingStylesState { items: ${items.length} }';

  @override
  ClothingStylesState getStateCopy() {
    return LoadedClothingStylesState(items: this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorClothingStylesState extends ClothingStylesState {
  final String errorMessage;

  ErrorClothingStylesState(this.errorMessage);

  @override
  String toString() => 'ErrorClothingStylesState { ${this.errorMessage} }';

  @override
  ClothingStylesState getStateCopy() {
    return ErrorClothingStylesState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
