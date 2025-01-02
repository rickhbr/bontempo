import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieGenresState extends Equatable {
  MovieGenresState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedMovieGenresState extends MovieGenresState {
  @override
  String toString() => 'UninitializedMovieGenresState';

  @override
  MovieGenresState getStateCopy() {
    return UninitializedMovieGenresState();
  }
}

class LoadingMovieGenresState extends MovieGenresState {
  @override
  String toString() => 'LoadingMovieGenresState';

  @override
  MovieGenresState getStateCopy() {
    return LoadingMovieGenresState();
  }
}

class LoadedMovieGenresState extends MovieGenresState {
  final List<MovieGenreModel> items;

  LoadedMovieGenresState(this.items);

  LoadedMovieGenresState copyWith({
    List<MovieGenreModel>? items,
  }) {
    return LoadedMovieGenresState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedMovieGenresState { items: ${items.length} }';

  @override
  MovieGenresState getStateCopy() {
    return LoadedMovieGenresState(this.items);
  }
}

class SavingMovieGenresState extends MovieGenresState {
  @override
  String toString() => 'SavingMovieGenresState';

  @override
  MovieGenresState getStateCopy() {
    return SavingMovieGenresState();
  }
}

class SavedMovieGenresState extends MovieGenresState {
  final Map<String, dynamic> response;

  SavedMovieGenresState(this.response);

  @override
  String toString() =>
      'SavedMovieGenresState { response: ${jsonEncode(this.response)} }';

  @override
  MovieGenresState getStateCopy() {
    return SavedMovieGenresState(this.response);
  }
}

class LoadingClientMovieGenresState extends MovieGenresState {
  @override
  String toString() => 'LoadingClientMovieGenresState';

  @override
  MovieGenresState getStateCopy() {
    return LoadingClientMovieGenresState();
  }
}

class LoadedClientMovieGenresState extends MovieGenresState {
  final List<MovieGenreModel> items;

  LoadedClientMovieGenresState(this.items);

  LoadedClientMovieGenresState copyWith({
    List<MovieGenreModel>? items,
  }) {
    return LoadedClientMovieGenresState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedMovieGenresState { items: ${items.length} }';

  @override
  MovieGenresState getStateCopy() {
    return LoadedMovieGenresState(this.items);
  }
}

class ErrorMovieGenresState extends MovieGenresState {
  final String errorMessage;

  ErrorMovieGenresState(this.errorMessage);

  @override
  String toString() => 'ErrorMovieGenresState { ${this.errorMessage} }';

  @override
  MovieGenresState getStateCopy() {
    return ErrorMovieGenresState(this.errorMessage);
  }
}

class CheckedMovieGenresState extends MovieGenresState {
  final bool selected;

  CheckedMovieGenresState(this.selected);

  @override
  String toString() => 'CheckedMovieGenresState { valid: ${this.selected} }';

  @override
  MovieGenresState getStateCopy() {
    return CheckedMovieGenresState(this.selected);
  }
}
