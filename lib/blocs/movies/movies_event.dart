import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMoviesEvent extends MoviesEvent {
  final int? idGenre;
  LoadMoviesEvent({this.idGenre});

  @override
  String toString() => 'LoadMoviesEvent: { idGenre: $idGenre }';
}

class MarkWatchedMoviesEvent extends MoviesEvent {
  final int? idMovie;
  MarkWatchedMoviesEvent({this.idMovie});

  @override
  String toString() => 'MarkWatchedMoviesEvent: { idMovie: $idMovie }';
}

class ResetMoviesEvent extends MoviesEvent {
  @override
  String toString() => 'ResetMoviesEvent';
}

class NextMovieEvent extends MoviesEvent {
  NextMovieEvent();

  @override
  String toString() => 'NextMovieEvent';
}
