import 'package:bontempo/main.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  static final HomeRepository _homeRepositorySingleton =
      new HomeRepository._internal();
  factory HomeRepository() {
    return _homeRepositorySingleton;
  }
  HomeRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<HomeModel> getHome() async {
    try {
      UserRepository userRepo = new UserRepository();
      final latitude = userRepo.geolocation?.latitude;
      final longitude = userRepo.geolocation?.longitude;

      Response response = await api.dio.get(
        '${api.endpoint}/home',
        queryParameters: {
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
        },
      );
      return new HomeModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
