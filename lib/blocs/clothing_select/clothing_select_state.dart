import 'package:bontempo/models/clothing_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingSelectState extends Equatable {
  ClothingSelectState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingSelectState extends ClothingSelectState {
  @override
  String toString() => 'UninitializedClothingSelectState';

  @override
  ClothingSelectState getStateCopy() {
    return UninitializedClothingSelectState();
  }
}

class SelectingClothingSelectState extends ClothingSelectState {
  @override
  String toString() => 'SelectingClothingSelectState';

  @override
  ClothingSelectState getStateCopy() {
    return SelectingClothingSelectState();
  }
}

class SelectedClothingSelectState extends ClothingSelectState {
  final List<ClothingModel> items;

  SelectedClothingSelectState(this.items);

  SelectedClothingSelectState copyWith({
    List<ClothingModel>? items,
  }) {
    return SelectedClothingSelectState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'SelectedClothingSelectState';

  @override
  ClothingSelectState getStateCopy() {
    return SelectedClothingSelectState(this.items);
  }

  @override
  List<Object> get props => [items];
}
