import 'package:bontempo/env.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/event_model.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventRepository {
  static final EventRepository _eventRepositorySingleton =
      EventRepository._internal();
  factory EventRepository() => _eventRepositorySingleton;
  EventRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();
  final Dio _dio = Dio();
  String? _accessToken;
  bool refreshed = false;

  Future<List<EventModel>> getDayEvents(String date) async {
    try {
      Response response = await _dio.get(
        'https://www.googleapis.com/calendar/v3/calendars/primary/events',
        queryParameters: {
          'key': environment['calendarKey'],
          'timeMin': '${date}T00:00:00-03:00',
          'timeMax': '${date}T23:59:59-03:00',
        },
        options: Options(
          receiveTimeout: Duration(seconds: 30),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $_accessToken'
          },
        ),
      );
      refreshed = false;
      if (response.statusCode == 401 && !refreshed) {
        refreshed = true;
        await authorizeCalendar();
        return await getDayEvents(date);
      }
      return List<EventModel>.from(
        response.data['items'].map((event) => EventModel.fromJson(event)),
      );
    } catch (error) {
      throw 'Ocorreu um erro';
    }
  }

  Future<String?> getCalendarToken() async {
    UserRepository userRepository = UserRepository();
    UserModel user = await userRepository.getUser();
    var shared = await SharedPreferences.getInstance();
    _accessToken = shared.getString('gcToken-${user.id}');
    return _accessToken;
  }

  Future<void> saveCalendarToken(String token) async {
    UserRepository userRepository = UserRepository();
    UserModel user = await userRepository.getUser();
    var shared = await SharedPreferences.getInstance();
    await shared.setString('gcToken-${user.id}', token);
    _accessToken = token;
  }

  Future<String?> authorizeCalendar() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/calendar.events.readonly',
          'https://www.googleapis.com/auth/calendar.readonly',
        ],
      );
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw 'Falha ao obter conta do Google';
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      await saveCalendarToken(googleSignInAuthentication.accessToken!);
      return googleSignInAuthentication.accessToken;
    } catch (error) {
      print(error);
      throw 'Ocorreu um erro.';
    }
  }
}
