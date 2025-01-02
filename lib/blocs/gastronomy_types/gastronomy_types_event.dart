import 'package:equatable/equatable.dart';

abstract class GastronomyTypesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadGastronomyTypesEvent extends GastronomyTypesEvent {
  LoadGastronomyTypesEvent();

  @override
  String toString() => 'LoadGastronomyTypesEvent';
}

class SaveGastronomyTypesEvent extends GastronomyTypesEvent {
  final List<int> ids;

  SaveGastronomyTypesEvent(this.ids);

  @override
  String toString() => 'SaveGastronomyTypesEvent';
}

class LoadClientGastronomyTypesEvent extends GastronomyTypesEvent {
  LoadClientGastronomyTypesEvent();

  @override
  String toString() => 'LoadClientGastronomyTypesEvent';
}

class CheckGastronomyTypesEvent extends GastronomyTypesEvent {
  CheckGastronomyTypesEvent();

  @override
  String toString() => 'CheckGastronomyTypesEvent';
}
