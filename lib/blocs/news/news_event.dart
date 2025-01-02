import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsEvent {
  LoadNewsEvent();

  @override
  String toString() => 'LoadNewsEvent';
}

class ResetNewsEvent extends NewsEvent {
  @override
  String toString() => 'ResetNewsEvent';
}
