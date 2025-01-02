import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/repositories/movie_genres_repository.dart';

class MovieGenresBloc extends Bloc<MovieGenresEvent, MovieGenresState> {
  MovieGenresBloc() : super(UninitializedMovieGenresState()) {
    on<LoadMovieGenresEvent>(_onLoadMovieGenresEvent);
    on<SaveMovieGenresEvent>(_onSaveMovieGenresEvent);
    on<LoadClientMovieGenresEvent>(_onLoadClientMovieGenresEvent);
    on<CheckMovieGenresEvent>(_onCheckMovieGenresEvent);
  }

  Future<void> _onLoadMovieGenresEvent(
    LoadMovieGenresEvent event,
    Emitter<MovieGenresState> emit,
  ) async {
    try {
      emit(LoadingMovieGenresState());
      MovieGenresRepository repository = MovieGenresRepository();
      List<MovieGenreModel> items = await repository.getMovieGenres();
      emit(LoadedMovieGenresState(items));
    } catch (error) {
      emit(ErrorMovieGenresState(error.toString()));
    }
  }

  Future<void> _onSaveMovieGenresEvent(
    SaveMovieGenresEvent event,
    Emitter<MovieGenresState> emit,
  ) async {
    try {
      emit(SavingMovieGenresState());
      MovieGenresRepository repository = MovieGenresRepository();
      Map<String, dynamic> response =
          await repository.saveMovieGenres(event.ids);
      emit(SavedMovieGenresState(response));
    } catch (error) {
      emit(ErrorMovieGenresState(error.toString()));
    }
  }

  Future<void> _onLoadClientMovieGenresEvent(
    LoadClientMovieGenresEvent event,
    Emitter<MovieGenresState> emit,
  ) async {
    try {
      emit(LoadingClientMovieGenresState());
      MovieGenresRepository repository = MovieGenresRepository();
      List<MovieGenreModel> items = await repository.getClientMovieGenres();
      emit(LoadedClientMovieGenresState(items));
    } catch (error) {
      emit(ErrorMovieGenresState(error.toString()));
    }
  }

  Future<void> _onCheckMovieGenresEvent(
    CheckMovieGenresEvent event,
    Emitter<MovieGenresState> emit,
  ) async {
    try {
      emit(SavingMovieGenresState());
      MovieGenresRepository repository = MovieGenresRepository();
      bool check = await repository.checkSelected();
      emit(CheckedMovieGenresState(check));
    } catch (error) {
      emit(ErrorMovieGenresState(error.toString()));
    }
  }
}
