import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/news_category_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCategoriesRepository {
  static final NewsCategoriesRepository _newsCategoriesRepositorySingleton =
      new NewsCategoriesRepository._internal();
  factory NewsCategoriesRepository() {
    return _newsCategoriesRepositorySingleton;
  }
  NewsCategoriesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();

  Future<List<NewsCategoryModel>> getNewsCategories() async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/news/categories',
      );
      return new List<NewsCategoryModel>.from(
        response.data['data']
            .map((category) => new NewsCategoryModel.fromJson(category)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> saveNewsCategories(List<int> ids) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.put(
        '${api.endpoint}/clients/${user.id}/news-categories',
        data: {
          'newsCategories': ids,
        },
      );
      await this.saveStorage(user.id);
      return {};
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<List<NewsCategoryModel>> getClientNewsCategories() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Response response = await api.dio.get(
        '${api.endpoint}/clients/${user.id}/news-categories',
      );
      return new List<NewsCategoryModel>.from(
        response.data.map((genre) => new NewsCategoryModel.fromJson(genre)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<void> saveStorage(int id) async {
    var shared = await SharedPreferences.getInstance();
    await shared.setString('newsCategories-$id', 'true');
    return;
  }

  Future<bool> checkSelected() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      var shared = await SharedPreferences.getInstance();
      String? value = shared.getString('newsCategories-${user.id}');
      if (value == 'true') {
        return true;
      } else {
        Response response = await api.dio.get(
          '${api.endpoint}/clients/${user.id}/news-categories',
        );
        List<NewsCategoryModel> list = new List<NewsCategoryModel>.from(
          response.data
              .map((category) => new NewsCategoryModel.fromJson(category)),
        );
        return list.isNotEmpty;
      }
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
