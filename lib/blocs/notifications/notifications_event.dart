import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNotificationsEvent extends NotificationsEvent {
  @override
  String toString() => 'LoadNotificationsEvent';
}
