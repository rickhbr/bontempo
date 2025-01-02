import 'dart:developer';

import 'package:bontempo/models/movie_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesState {
  MoviesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedMoviesState extends MoviesState {
  @override
  String toString() => 'UninitializedMoviesState';

  @override
  MoviesState getStateCopy() {
    return UninitializedMoviesState();
  }
}

class LoadingMoviesState extends MoviesState {
  @override
  String toString() => 'LoadingMoviesState';

  @override
  MoviesState getStateCopy() {
    return LoadingMoviesState();
  }
}

class LoadedMoviesState extends MoviesState {
  final List<MovieModel>? items;
  final bool? hasReachedMax;
  final int? page;

  LoadedMoviesState({this.items, this.hasReachedMax, this.page});

  LoadedMoviesState copyWith({
    List<MovieModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedMoviesState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedMoviesState { items: ${items!.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  MoviesState getStateCopy() {
    return LoadedMoviesState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }
}

class ErrorMoviesState extends MoviesState {
  final String errorMessage;

  ErrorMoviesState(this.errorMessage);

  @override
  String toString() => 'ErrorMoviesState { ${this.errorMessage} }';

  @override
  MoviesState getStateCopy() {
    return ErrorMoviesState(this.errorMessage);
  }
}

class WatchedMovieState extends MoviesState {
  final MovieModel? movie;

  WatchedMovieState({this.movie});

  WatchedMovieState copyWith({
    MovieModel? movie,
  }) {
    return WatchedMovieState(
      movie: movie ?? this.movie,
    );
  }

  @override
  String toString() => 'WatchedMovieState { movie: $movie}';

  @override
  MoviesState getStateCopy() {
    return WatchedMovieState(
      movie: this.movie,
    );
  }
}

class NewMovieState extends MoviesState {
  final MovieModel? movie;

  NewMovieState(this.movie);

  NewMovieState copyWith({MovieModel? movie}) {
    return NewMovieState(movie ?? this.movie);
  }

  @override
  String toString() => 'NewMovieState';

  @override
  MoviesState getStateCopy() {
    return NewMovieState(this.movie);
  }
}
