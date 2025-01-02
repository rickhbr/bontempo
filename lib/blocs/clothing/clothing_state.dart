import 'package:equatable/equatable.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingState extends Equatable {
  ClothingState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingState extends ClothingState {
  @override
  String toString() => 'UninitializedClothingState';

  @override
  ClothingState getStateCopy() {
    return UninitializedClothingState();
  }
}

class LoadingClothingState extends ClothingState {
  @override
  String toString() => 'LoadingClothingState';

  @override
  ClothingState getStateCopy() {
    return LoadingClothingState();
  }
}

class LoadedAllClothingState extends ClothingState {
  final List<ClothingModel> items;

  LoadedAllClothingState({required this.items});

  LoadedAllClothingState copyWith({
    List<ClothingModel>? items,
  }) {
    return LoadedAllClothingState(
      items: items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedAllClothingState { items: ${items.length} }';

  @override
  ClothingState getStateCopy() {
    return LoadedAllClothingState(
      items: this.items,
    );
  }

  @override
  List<Object> get props => [items];
}

class LoadedClothingState extends ClothingState {
  final List<ClothingModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedClothingState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedClothingState copyWith({
    List<ClothingModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedClothingState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedClothingState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  ClothingState getStateCopy() {
    return LoadedClothingState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class RemovingClothingState extends ClothingState {
  @override
  String toString() => 'RemovingClothingState';

  @override
  ClothingState getStateCopy() {
    return RemovingClothingState();
  }
}

class RemovedClothingState extends ClothingState {
  final int idClothing;

  RemovedClothingState(this.idClothing);

  RemovedClothingState copyWith(int idClothing) {
    return RemovedClothingState(idClothing);
  }

  @override
  String toString() => 'RemovedClothingState { idClothing: $idClothing }';

  @override
  ClothingState getStateCopy() {
    return RemovedClothingState(idClothing);
  }

  @override
  List<Object> get props => [idClothing];
}

class EditingClothingState extends ClothingState {
  @override
  String toString() => 'EditingClothingState';

  @override
  ClothingState getStateCopy() {
    return EditingClothingState();
  }
}

class EditedClothingState extends ClothingState {
  final ClothingModel clothing;

  EditedClothingState(this.clothing);

  EditedClothingState copyWith({ClothingModel? clothing}) {
    return EditedClothingState(clothing ?? this.clothing);
  }

  @override
  String toString() => 'EditedClothingState';

  @override
  ClothingState getStateCopy() {
    return EditedClothingState(this.clothing);
  }

  @override
  List<Object> get props => [clothing];
}

class ErrorClothingState extends ClothingState {
  final String errorMessage;

  ErrorClothingState(this.errorMessage);

  @override
  String toString() => 'ErrorClothingState { ${this.errorMessage} }';

  @override
  ClothingState getStateCopy() {
    return ErrorClothingState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
