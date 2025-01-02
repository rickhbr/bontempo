import 'package:equatable/equatable.dart';

abstract class ClothingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllClothingEvent extends ClothingEvent {
  final int? categoryId;
  final int? colorId;
  LoadAllClothingEvent({this.categoryId, this.colorId});

  @override
  String toString() =>
      'LoadAllClothingEvent: { categoryId: ${this.categoryId}, colorId: ${this.colorId} } ';
}

class ResetClothingEvent extends ClothingEvent {
  @override
  String toString() => 'ResetClothingEvent';
}

class LoadClothingEvent extends ClothingEvent {
  @override
  String toString() => 'LoadClothingEvent';
}

class RemoveClothingEvent extends ClothingEvent {
  final int idClothing;
  RemoveClothingEvent(this.idClothing);

  @override
  String toString() => 'RemoveClothingEvent { id: $idClothing }';
}

class EditClothingEvent extends ClothingEvent {
  final int? idClothing;
  final Map<String, dynamic>? data;
  EditClothingEvent({this.idClothing, this.data});

  @override
  String toString() => 'EditClothingEvent { idClothing: $idClothing }';
}
