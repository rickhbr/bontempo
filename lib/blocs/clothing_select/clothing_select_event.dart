import 'package:bontempo/models/clothing_model.dart';
import 'package:equatable/equatable.dart';

abstract class ClothingSelectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetSelectClothingEvent extends ClothingSelectEvent {
  final List<ClothingModel> items;
  SetSelectClothingEvent(this.items);

  @override
  String toString() => 'SetSelectClothingEvent';
}

class SelectClothingEvent extends ClothingSelectEvent {
  final ClothingModel item;
  SelectClothingEvent(this.item);

  @override
  String toString() => 'SelectClothingEvent';
}

class UnselectClothingEvent extends ClothingSelectEvent {
  final ClothingModel item;
  UnselectClothingEvent(this.item);

  @override
  String toString() => 'UnselectClothingEvent';
}
