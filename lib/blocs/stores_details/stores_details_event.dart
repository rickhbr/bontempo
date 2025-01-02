import 'package:equatable/equatable.dart';

abstract class StoresDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadArchitectsEvent extends StoresDetailsEvent {
  LoadArchitectsEvent();

  @override
  String toString() => 'LoadArchitectsEvent';
}

class LoadProjectsEvent extends StoresDetailsEvent {
  final int storeId;
  LoadProjectsEvent(this.storeId);

  @override
  String toString() => 'LoadProjectsEvent';
}
