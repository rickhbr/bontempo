import 'package:equatable/equatable.dart';

abstract class ClothingCategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadClothingCategoriesEvent extends ClothingCategoriesEvent {
  LoadClothingCategoriesEvent();

  @override
  String toString() => 'LoadClothingCategoriesEvent';
}
