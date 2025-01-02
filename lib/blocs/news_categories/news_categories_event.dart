import 'package:equatable/equatable.dart';

abstract class NewsCategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNewsCategoriesEvent extends NewsCategoriesEvent {
  LoadNewsCategoriesEvent();

  @override
  String toString() => 'LoadNewsCategoriesEvent';
}

class SaveNewsCategoriesEvent extends NewsCategoriesEvent {
  final List<int> ids;

  SaveNewsCategoriesEvent(this.ids);

  @override
  String toString() => 'SaveNewsCategoriesEvent';
}

class LoadClientNewsCategoriesEvent extends NewsCategoriesEvent {
  LoadClientNewsCategoriesEvent();

  @override
  String toString() => 'LoadClientNewsCategoriesEvent';
}

class CheckNewsCategoriesEvent extends NewsCategoriesEvent {
  CheckNewsCategoriesEvent();

  @override
  String toString() => 'CheckNewsCategoriesEvent';
}
