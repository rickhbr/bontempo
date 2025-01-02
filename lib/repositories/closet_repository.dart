import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/closet_model.dart';
import 'package:bontempo/providers/api.dart';

class ClosetRepository {
  static final ClosetRepository _closetRepositorySingleton =
      new ClosetRepository._internal();
  factory ClosetRepository() {
    return _closetRepositorySingleton;
  }
  ClosetRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<ClosetModel> getCloset() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      Response response = await api.dio.get(
        '${api.endpoint}/clothing/${user.id}/dashboard',
      );
      return ClosetModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
