import 'package:equatable/equatable.dart';

abstract class MovieGenresEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMovieGenresEvent extends MovieGenresEvent {
  LoadMovieGenresEvent();

  @override
  String toString() => 'LoadMovieGenresEvent';
}

class SaveMovieGenresEvent extends MovieGenresEvent {
  final List<int> ids;

  SaveMovieGenresEvent(this.ids);

  @override
  String toString() => 'SaveMovieGenresEvent';
}

class LoadClientMovieGenresEvent extends MovieGenresEvent {
  LoadClientMovieGenresEvent();

  @override
  String toString() => 'LoadClientMovieGenresEvent';
}

class CheckMovieGenresEvent extends MovieGenresEvent {
  CheckMovieGenresEvent();

  @override
  String toString() => 'CheckMovieGenresEvent';
}
