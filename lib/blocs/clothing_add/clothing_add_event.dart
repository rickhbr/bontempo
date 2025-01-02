import 'package:equatable/equatable.dart';

abstract class ClothingAddEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddClothingEvent extends ClothingAddEvent {
  final Map<String, dynamic> data;
  AddClothingEvent(this.data);

  @override
  String toString() => 'AddClothingEvent';
}
