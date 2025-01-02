import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/movies/index.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:bontempo/repositories/movies_repository.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository = MoviesRepository();

  MoviesBloc() : super(UninitializedMoviesState()) {
    on<LoadMoviesEvent>(_onLoadMoviesEvent);
    on<MarkWatchedMoviesEvent>(_onMarkWatchedMoviesEvent);
    on<ResetMoviesEvent>(_onResetMoviesEvent);
    on<NextMovieEvent>(_onNextMovieEvent);
  }

  void _onLoadMoviesEvent(
      LoadMoviesEvent event, Emitter<MoviesState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingMoviesState) {
      try {
        if (currentState is UninitializedMoviesState) {
          emit(LoadingMoviesState());
          Map<String, dynamic> data = await repository.getMovies(
            page: 1,
            idGenre: event.idGenre,
          );
          emit(LoadedMoviesState(
            items: List<MovieModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else {
          var state = currentState as LoadedMoviesState;
          emit(LoadingMoviesState());
          Map<String, dynamic> data = await repository.getMovies(
            page: state.page! + 1,
            idGenre: event.idGenre,
          );

          List<MovieModel> items = List<MovieModel>.from(data['items']);
          emit(items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedMoviesState(
                  items: items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorMoviesState(error.toString()));
      }
    }
  }

  void _onMarkWatchedMoviesEvent(
      MarkWatchedMoviesEvent event, Emitter<MoviesState> emit) async {
    try {
      MovieModel movie = await repository.markWatched(event.idMovie!);
      emit(WatchedMovieState(movie: movie));
    } catch (error) {
      emit(ErrorMoviesState(error.toString()));
    }
  }

  void _onResetMoviesEvent(ResetMoviesEvent event, Emitter<MoviesState> emit) {
    emit(UninitializedMoviesState());
  }

  void _onNextMovieEvent(
      NextMovieEvent event, Emitter<MoviesState> emit) async {
    try {
      MovieModel movie = await repository.nextMovie();
      emit(NewMovieState(movie));
    } catch (error) {
      emit(ErrorMoviesState(error.toString()));
    }
  }

  bool _hasReachedMax(MoviesState state) =>
      state is LoadedMoviesState && state.hasReachedMax!;
}
