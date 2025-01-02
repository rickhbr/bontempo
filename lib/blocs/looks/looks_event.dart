import 'package:equatable/equatable.dart';

abstract class LooksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLooksEvent extends LooksEvent {
  LoadLooksEvent();

  @override
  String toString() => 'LoadLooksEvent';
}

class ResetLooksEvent extends LooksEvent {
  @override
  String toString() => 'ResetLooksEvent';
}

class DeleteLookEvent extends LooksEvent {
  final int idLook;

  DeleteLookEvent(this.idLook);

  @override
  String toString() => 'DeleteLookEvent: { idLook: ${this.idLook} }';
}
