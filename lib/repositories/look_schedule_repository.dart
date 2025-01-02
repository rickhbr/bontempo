import 'package:bontempo/models/look_calendar_model.dart';
import 'package:bontempo/models/look_schedule_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';

class LooksScheduleRepository {
  static final LooksScheduleRepository _looksScheduleRepositorySingleton =
      new LooksScheduleRepository._internal();
  factory LooksScheduleRepository() {
    return _looksScheduleRepositorySingleton;
  }
  LooksScheduleRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<List<LookCalendarModel>> getCalendar() async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      Response response = await api.dio.get(
        '${api.endpoint}/looks/schedule/${user.id}/calendar',
      );
      return new List<LookCalendarModel>.from(
        response.data.map((date) => new LookCalendarModel.fromJson(date)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<List<LookScheduleModel>> getByDate(String date) async {
    try {
      UserRepository userRepository = new UserRepository();
      UserModel user = await userRepository.getUser();

      Response response = await api.dio.get(
        '${api.endpoint}/looks/schedule/${user.id}/date',
        queryParameters: {'date': date},
      );
      return new List<LookScheduleModel>.from(
        response.data.map((item) => new LookScheduleModel.fromJson(item)),
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<LookScheduleModel> addLookSchedule({String? date, int? idLook}) async {
    try {
      Response response = await api.dio.post(
        '${api.endpoint}/looks/schedule',
        data: {
          'look_id': idLook,
          'date': date,
        },
      );
      return new LookScheduleModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<int> deleteLookSchedule(int idSchedule) async {
    try {
      await api.dio.delete(
        '${api.endpoint}/looks/schedule/$idSchedule',
      );
      return idSchedule;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
