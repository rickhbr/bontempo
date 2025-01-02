import 'package:equatable/equatable.dart';

abstract class ClothingColorsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadClothingColorsEvent extends ClothingColorsEvent {
  @override
  String toString() => 'LoadClothingColorsEvent';
}
