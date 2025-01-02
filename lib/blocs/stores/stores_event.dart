import 'package:equatable/equatable.dart';

abstract class StoresEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStoresEvent extends StoresEvent {
  @override
  String toString() => 'LoadStoresEvent';
}
