import 'package:equatable/equatable.dart';

abstract class LookManageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddLookEvent extends LookManageEvent {
  final Map<String, dynamic> data;
  AddLookEvent(this.data);

  @override
  String toString() => 'AddLookEvent';
}

class EditLookEvent extends LookManageEvent {
  final int id;
  final Map<String, dynamic> data;
  EditLookEvent(this.id, this.data);

  @override
  String toString() => 'EditLookEvent';
}
