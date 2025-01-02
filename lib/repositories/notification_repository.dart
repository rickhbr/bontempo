import 'package:bontempo/main.dart';
import 'package:bontempo/models/notification_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class NotificationRepository {
  static final NotificationRepository _notificationRepositorySingleton =
      new NotificationRepository._internal();
  factory NotificationRepository() {
    return _notificationRepositorySingleton;
  }
  NotificationRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  int unread = 0;

  // Bugfix/gambiarra pra contornar problema do firebase de receber notificação duas vezes
  bool notificationIsOpened = false;

  Future<Map<String, dynamic>> getNotifications({
    int page = 1,
  }) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      Map<String, dynamic> params = {'page': page};
      Response response = await api.dio.get(
        '${api.endpoint}/notifications/${user.id}',
        queryParameters: params,
      );
      Map<String, dynamic> data = response.data;

      this.unread = data['unread'];

      data['items'] = new List<NotificationModel>.from(
        data['data']['data'].map(
          (notification) => new NotificationModel.fromJson(notification),
        ),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> readNotification(String notificationCode) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      var response = await api.dio.put(
        '${api.endpoint}/notifications/${user.id}/$notificationCode',
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  void readAll() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      await api.dio.put('${api.endpoint}/notifications/${user.id}',
          queryParameters: {'readAll': 1});
      this.unread = 0;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
