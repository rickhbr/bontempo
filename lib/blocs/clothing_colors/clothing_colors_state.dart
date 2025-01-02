import 'package:bontempo/models/clothing_color_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingColorsState extends Equatable {
  ClothingColorsState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingColorsState extends ClothingColorsState {
  @override
  String toString() => 'UninitializedClothingColorsState';

  @override
  ClothingColorsState getStateCopy() {
    return UninitializedClothingColorsState();
  }
}

class LoadingClothingColorsState extends ClothingColorsState {
  @override
  String toString() => 'LoadingClothingColorsState';

  @override
  ClothingColorsState getStateCopy() {
    return LoadingClothingColorsState();
  }
}

class LoadedClothingColorsState extends ClothingColorsState {
  final List<ClothingColorModel> items;

  LoadedClothingColorsState({required this.items});

  LoadedClothingColorsState copyWith({
    List<ClothingColorModel>? items,
  }) {
    return LoadedClothingColorsState(
      items: items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedClothingColorsState { items: ${items.length} }';

  @override
  ClothingColorsState getStateCopy() {
    return LoadedClothingColorsState(items: this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorClothingColorsState extends ClothingColorsState {
  final String errorMessage;

  ErrorClothingColorsState(this.errorMessage);

  @override
  String toString() => 'ErrorClothingColorsState { ${this.errorMessage} }';

  @override
  ClothingColorsState getStateCopy() {
    return ErrorClothingColorsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
