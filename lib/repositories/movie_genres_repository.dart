import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieGenresRepository {
  static final MovieGenresRepository _movieGenresRepositorySingleton =
      new MovieGenresRepository._internal();
  factory MovieGenresRepository() {
    return _movieGenresRepositorySingleton;
  }
  MovieGenresRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();

  Future<List<MovieGenreModel>> getMovieGenres() async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/movies/genres',
      );
      return new List<MovieGenreModel>.from(
        response.data['data']
            .map((genre) => new MovieGenreModel.fromJson(genre)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> saveMovieGenres(List<int> ids) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.put(
        '${api.endpoint}/clients/${user.id}/movie-genres',
        data: {
          'genres': ids,
        },
      );
      await this.saveStorage(user.id);
      return {};
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<void> saveStorage(int id) async {
    var shared = await SharedPreferences.getInstance();
    await shared.setString('movieGenres-$id', 'true');
    return;
  }

  Future<List<MovieGenreModel>> getClientMovieGenres() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Response response = await api.dio.get(
        '${api.endpoint}/clients/${user.id}/movie-genres',
      );
      return new List<MovieGenreModel>.from(
        response.data.map((genre) => new MovieGenreModel.fromJson(genre)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<bool> checkSelected() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      var shared = await SharedPreferences.getInstance();
      String? value = shared.getString('movieGenres-${user.id}');
      if (value == 'true') {
        return true;
      } else {
        Response response = await api.dio.get(
          '${api.endpoint}/clients/${user.id}/movie-genres',
        );
        List<MovieGenreModel> list = new List<MovieGenreModel>.from(
          response.data.map((genre) => new MovieGenreModel.fromJson(genre)),
        );
        return list.isNotEmpty;
      }
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
