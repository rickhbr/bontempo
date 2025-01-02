import 'package:equatable/equatable.dart';

abstract class ClothingStylesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadClothingStylesEvent extends ClothingStylesEvent {
  @override
  String toString() => 'LoadClothingStylesEvent';
}
