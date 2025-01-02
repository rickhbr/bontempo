import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';

class LookRepository {
  static final LookRepository _lookRepositorySingleton =
      LookRepository._internal();
  factory LookRepository() {
    return _lookRepositorySingleton;
  }
  LookRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getLooks({int page = 1}) async {
    try {
      UserRepository userRepository = UserRepository();
      UserModel user = await userRepository.getUser();

      Response response = await api.dio.get(
        '${api.endpoint}/looks/${user.id}',
        queryParameters: {'page': page},
      );
      Map<String, dynamic> data = response.data;
      data['items'] = List<LookModel>.from(
        data['data'].map((looks) => LookModel.fromJson(looks)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> addLook(Map<String, dynamic> data) async {
    try {
      UserRepository userRepository = UserRepository();
      UserModel user = await userRepository.getUser();

      Response response = await api.dio.post(
        '${api.endpoint}/looks/${user.id}',
        data: data,
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> editLook(
      int idLook, Map<String, dynamic> data) async {
    try {
      UserRepository userRepository = UserRepository();
      UserModel user = await userRepository.getUser();

      print('${api.endpoint}/looks/${user.id}/$idLook');

      Response response = await api.dio.put(
        '${api.endpoint}/looks/${user.id}/$idLook',
        data: data,
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<List<ClothingModel>?> skipLook() async {
    try {
      UserRepository userRepo = UserRepository();
      Response response = await api.dio.get(
        '${api.endpoint}/looks/generate',
        queryParameters: {
          'latitude': userRepo.geolocation!.latitude,
          'longitude': userRepo.geolocation!.longitude,
        },
      );
      return response.data != ''
          ? List<ClothingModel>.from(
              response.data.map((clothing) => ClothingModel.fromJson(clothing)),
            )
          : null;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<int> deleteLook(int idLook) async {
    try {
      UserRepository userRepository = UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.delete(
        '${api.endpoint}/looks/${user.id}/$idLook',
      );
      return idLook;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
