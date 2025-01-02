import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';

class ClothingRepository {
  static final ClothingRepository _clothingRepositorySingleton =
      new ClothingRepository._internal();
  factory ClothingRepository() {
    return _clothingRepositorySingleton;
  }
  ClothingRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> addClothing(Map<String, dynamic> data) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      print('endpoint: ${'${api.endpoint}/clothing/${user.id}'}');
      print('data: $data');

      Response response = await api.dio.post(
        '${api.endpoint}/clothing/${user.id}',
        data: data,
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<ClothingModel> editClothing(
    int idClothing,
    Map<String, dynamic> data,
  ) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Response response = await api.dio.put(
        '${api.endpoint}/clothing/${user.id}/$idClothing',
        data: data,
      );
      return new ClothingModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<int> deleteClothing(int idClothing) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.delete(
        '${api.endpoint}/clothing/${user.id}/$idClothing',
      );
      return idClothing;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<List<ClothingModel>> getAllClothes({
    int categoryId = 0,
    int colorId = 0,
  }) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Map<String, dynamic> params = {'unlimited': true, 'search': {}};
      if (categoryId != null) {
        params['search']['category_id'] = categoryId;
      }
      if (colorId != null) {
        params['search']['color_id'] = colorId;
      }
      Response response = await api.dio.get(
        '${api.endpoint}/clothing/${user.id}',
        queryParameters: params,
      );
      print('Response data: ${response.data}'); // Log the response data
      List<ClothingModel> items = List<ClothingModel>.from(
        response.data.map((clothing) => new ClothingModel.fromJson(clothing)),
      );
      print('Parsed items: $items'); // Log the parsed items
      return items;
    } catch (error) {
      print('Error: $error'); // Log the error
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> getClothes({int page = 1}) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Response response = await api.dio.get(
        '${api.endpoint}/clothing/${user.id}',
        queryParameters: {
          'page': page,
        },
      );
      Map<String, dynamic> data = response.data;
      data['items'] = new List<ClothingModel>.from(
        data['data'].map((movie) => new ClothingModel.fromJson(movie)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
