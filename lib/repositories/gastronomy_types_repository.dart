import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GastronomyTypesRepository {
  static final GastronomyTypesRepository _gastronomyTypesRepositorySingleton =
      new GastronomyTypesRepository._internal();
  factory GastronomyTypesRepository() {
    return _gastronomyTypesRepositorySingleton;
  }
  GastronomyTypesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();

  Future<List<GastronomyTypeModel>> getGastronomyTypes() async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/gastronomy/types',
      );
      return new List<GastronomyTypeModel>.from(
        response.data['data'].map((gastronomyType) =>
            new GastronomyTypeModel.fromJson(gastronomyType)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> saveGastronomyTypes(List<int> ids) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.put(
        '${api.endpoint}/clients/${user.id}/gastronomy-types',
        data: {
          'types': ids,
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
    await shared.setString('gastronomyTypes-$id', 'true');
    return;
  }

  Future<List<GastronomyTypeModel>> getClientGastronomyTypes() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();
      Response response = await api.dio.get(
        '${api.endpoint}/clients/${user.id}/gastronomy-types',
      );
      return new List<GastronomyTypeModel>.from(
        response.data.map((genre) => new GastronomyTypeModel.fromJson(genre)),
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
      String? value = shared.getString('gastronomyTypes-${user.id}');

      if (value != null && value == 'true') {
        return true;
      } else {
        Response response = await api.dio.get(
          '${api.endpoint}/clients/${user.id}/gastronomy-types',
        );
        List<GastronomyTypeModel> list = new List<GastronomyTypeModel>.from(
          response.data.map((genre) => new GastronomyTypeModel.fromJson(genre)),
        );
        return list.length > 0;
      }
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
