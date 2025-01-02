import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:bontempo/providers/api.dart';

class MoviesRepository {
  static final MoviesRepository _moviesRepositorySingleton =
      new MoviesRepository._internal();
  factory MoviesRepository() {
    return _moviesRepositorySingleton;
  }
  MoviesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getMovies({int page = 1, int? idGenre}) async {
    try {
      Map<String, dynamic> params = {
        'page': page,
        'sort': {'rating': 'DESC'},
      };
      if (idGenre != null) {
        params['genre'] = idGenre;
      }
      Response response = await api.dio.get(
        '${api.endpoint}/movies',
        queryParameters: params,
      );
      Map<String, dynamic> data = response.data;
      data['items'] = new List<MovieModel>.from(
        data['data'].map((movie) => new MovieModel.fromJson(movie)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<MovieModel> markWatched(int idMovie) async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/movie/mark-watched/$idMovie',
      );
      MovieModel movie = new MovieModel.fromJson(
          response.data.length > 0 ? response.data[0] : null);
      return movie;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<MovieModel> nextMovie() async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/movies/next',
      );
      MovieModel movie =
          new MovieModel.fromJson(response.data != null ? response.data : null);
      return movie;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
