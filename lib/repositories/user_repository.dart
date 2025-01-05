import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/providers/geolocation.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserRepository {
  static final UserRepository _userRepositorySingleton = UserRepository._internal();
  factory UserRepository() {
    return _userRepositorySingleton;
  }
  UserRepository._internal();

  UserModel? user;
  String? fcmToken;
  Position? geolocation;
  late StreamSubscription iosSubscription;

  final ApiProvider api = getIt.get<ApiProvider>();
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();

  Future<void> initialize() async {
    await _initializeFCMToken();
  }

  Future<void> _initializeFCMToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
  }

  Future<void> initializeGeolocation() async {
    geolocation = await Geolocation.getUserPosition();
  }

  Future<UserModel> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      await initializeGeolocation(); // Initialize geolocation before using it
      Response response = await api.dio.post('${api.endpoint}/auth/login', data: {
        'email': email,
        'password': password,
        'fcm_token': await this.getFCMToken(),
        'latitude': geolocation!.latitude,
        'longitude': geolocation!.longitude,
      });

      String token = response.data['token'];
      var shared = await SharedPreferences.getInstance();
      await shared.setString('token', token);
      Response meResponse = await api.dio.get('${api.endpoint}/me');
      UserModel user = UserModel.fromJson(meResponse.data);
      await this.persistUser(user: user, token: token);
      return user;
    } catch (error) {
      print("auth_error $error");
      throw api.handleError(error);
    }
  }

  Future<UserModel> googleAuthenticate() async {
    try {
      await initializeGeolocation(); // Initialize geolocation before using it
      GoogleSignInAccount? account;
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      _googleSignIn.onCurrentUserChanged.listen(
        (GoogleSignInAccount? acc) async {
          account = acc;
        },
      );
      _googleSignIn.signInSilently();
      await _googleSignIn.signIn();
      int counter = 0;
      while (counter < 10) {
        await Future.delayed(Duration(milliseconds: 200));
        counter++;
      }
      Response response = await api.dio.post(
        '${api.endpoint}/auth/login-social',
        data: {
          'type': 'google',
          'email': account!.email,
          'avatar': account!.photoUrl,
          'name': account!.displayName,
          'fcm_token': await this.getFCMToken(),
          'latitude': geolocation!.latitude,
          'longitude': geolocation!.longitude,
        },
      );
      String token = response.data['token'];

      var shared = await SharedPreferences.getInstance();
      await shared.setString('token', token);
      Response meResponse = await api.dio.get('${api.endpoint}/me');
      UserModel user = UserModel.fromJson(meResponse.data);
      await this.persistUser(user: user, token: token);
      return user;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<UserModel> facebookAuthenticate() async {
    try {
      await initializeGeolocation(); // Initialize geolocation before using it
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final AccessToken accessToken = result.accessToken!;
          final Dio dio = Dio();

          final Response graphResponse = await dio.get(
            'https://graph.facebook.com/v6.0/me?fields=name,email,picture&access_token=${accessToken.tokenString}',
          );

          final account = jsonDecode(graphResponse.data);
          Response response = await api.dio.post(
            '${api.endpoint}/auth/login-social',
            data: {
              'type': 'facebook',
              'email': account['email'],
              'avatar': account['picture'] != null && account['picture']['data'] != null
                  ? account['picture']['data']['url']
                  : null,
              'name': account['name'],
              'fcm_token': await this.getFCMToken(),
              'latitude': geolocation!.latitude,
              'longitude': geolocation!.longitude,
            },
          );

          String token = response.data['token'];
          var shared = await SharedPreferences.getInstance();
          await shared.setString('token', token);

          Response meResponse = await api.dio.get('${api.endpoint}/me');
          UserModel user = UserModel.fromJson(meResponse.data);
          await this.persistUser(user: user, token: token);
          return user;

        case LoginStatus.cancelled:
          throw 'Ocorreu um erro. Por favor, tente novamente.';

        case LoginStatus.failed:
          throw result.message!;

        default:
          throw 'Ocorreu um erro. Por favor, tente novamente.';
      }
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<UserModel> appleAuthenticate() async {
    try {
      await initializeGeolocation(); // Initialize geolocation before using it
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);

      Response response = await api.dio.post(
        '${api.endpoint}/auth/login-apple',
        data: {
          'apple_token': credential.identityToken,
          'name': "${credential.givenName} ${credential.familyName}",
          'fcm_token': await this.getFCMToken(),
          'latitude': geolocation!.latitude,
          'longitude': geolocation!.longitude,
        },
      );
      String token = response.data['token'];
      var shared = await SharedPreferences.getInstance();
      await shared.setString('token', token);
      Response meResponse = await api.dio.get('${api.endpoint}/me');
      UserModel user = UserModel.fromJson(meResponse.data);
      await this.persistUser(user: user, token: token);
      return user;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<void> deleteToken() async {
    try {
      await api.dio.post('${api.endpoint}/auth/logout');
    } catch (error) {}
    await storage.delete(key: 'token');
    await storage.delete(key: 'user');
    return;
  }

  Future<void> persistUser({UserModel? user, String? token}) async {
    if (user == null) {
      throw Exception("User não pode ser nulo");
    }

    this.user = user;
    var shared = await SharedPreferences.getInstance();

    if (token != null && token.isNotEmpty) {
      await shared.setString('token', token);
    }

    await shared.setString('user', jsonEncode(user.toJson()));
    return;
  }

  Future<UserModel> reloadUser() async {
    Response meResponse = await api.dio.get('${api.endpoint}/me');
    UserModel user = UserModel.fromJson(meResponse.data);
    await this.persistUser(user: user);
    return user;
  }

  Future<UserModel> getUser() async {
    var shared = await SharedPreferences.getInstance();
    String userString = shared.getString('user')!;
    Map<String, dynamic> userJson = jsonDecode(userString);
    this.user = UserModel.fromJson(userJson);
    return this.user!;
  }

  dynamic getUserFastParam(String key) {
    Map<String, dynamic> user = this.user!.toJson();
    if (key == 'avatarUrl') {
      return user['avatar']['url'];
    }
    return user[key];
  }

  Future<dynamic> getUserParam(String key) async {
    var shared = await SharedPreferences.getInstance();
    String userString = shared.getString('user')!;
    Map<String, dynamic> user = jsonDecode(userString);
    return user[key];
  }

  Future<String?> getToken() async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString('token');
  }

  Future<bool> hasToken() async {
    var shared = await SharedPreferences.getInstance();
    dynamic value = shared.getString('token');

    if (value is String && value != "") {
      try {
        await initializeGeolocation(); // Initialize geolocation before using it
        Response response = await api.dio.get('${api.endpoint}/me');
        UserModel user = UserModel.fromJson(response.data);
        if (user != null) {
          await this.persistUser(user: user);
          return true;
        } else {
          this.deleteToken();
        }
        return false;
      } catch (error) {
        InternetAddress.lookup('google.com').catchError((err) {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            NoConnectionViewRoute,
            (Route<dynamic> route) => false,
          );
        });
        return true;
      }
    }
    return false;
  }

  Future<UserModel> registerUser(Map<String, dynamic> data) async {
    try {
      geolocation = await Geolocation.getUserPosition();
      print("Geolocation inicializada: ${geolocation!.latitude}, ${geolocation!.longitude}");

      var shared = await SharedPreferences.getInstance();
      String fcmToken = await this.getFCMToken();
      print("FCM Token obtido: $fcmToken");

      if (fcmToken.isEmpty) {
        throw Exception("FCM Token não pode ser vazio");
      }

      print("Dados para registro: $data");
      print("Latitude: ${geolocation!.latitude}, Longitude: ${geolocation!.longitude}");

      Response response = await api.dio.post(
        '${api.endpoint}/clients',
        data: {
          ...data,
          'fcm_token': fcmToken,
          'latitude': geolocation!.latitude,
          'longitude': geolocation!.longitude,
        },
      );

      print("Resposta da API: ${response.data}");

      String? token = response.data['token'];
      if (token == null || token.isEmpty) {
        throw Exception("Token não pode ser nulo ou vazio");
      }
      await shared.setString('token', token);

      Map<String, dynamic>? clientData = response.data['client'];
      if (clientData == null) {
        throw Exception("Dados do cliente não podem ser nulos");
      }

      UserModel user = UserModel.fromJson(clientData);
      await this.persistUser(user: user, token: token);
      return user;
    } catch (error) {
      print("Erro no registro: $error");
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> saveUser(Map<String, dynamic> data) async {
    try {
      Response response = await api.dio.put(
        '${api.endpoint}/clients/${this.user!.id}',
        data: {...data},
      );
      UserModel user = UserModel.fromJson(response.data);
      await this.persistUser(user: user);
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> updatePassword(
    String password,
    String repeatPassword,
  ) async {
    try {
      Response response = await api.dio.put(
        '${api.endpoint}/clients/${this.user!.id}/password',
        data: {
          'password': password,
          'repeat_password': repeatPassword,
        },
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<String> retrievePassword(String email) async {
    try {
      Response response = await api.dio.post(
        '${api.endpoint}/auth/retrieve-password',
        data: {'email': email},
      );
      return response.data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  // Retorna FCM Token pros pushs
  Future<String> getFCMToken() async {
    if (fcmToken != null && fcmToken!.isNotEmpty) {
      return fcmToken!;
    }
    await requestFCMToken();
    if (fcmToken == null || fcmToken!.isEmpty) {
      throw Exception("Não foi possível obter o FCM Token");
    }
    return fcmToken!;
  }

  Future<void> requestFCMToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    if (Platform.isIOS && fcmToken == null) {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        fcmToken = await _firebaseMessaging.getToken();
        print("FCM Token para iOS: $fcmToken");
      } else {
        print('User declined or has not accepted permission');
      }
    } else if (fcmToken == null) {
      fcmToken = await _firebaseMessaging.getToken();
      print("FCM Token para outras plataformas: $fcmToken");
    }

    if (fcmToken == null || fcmToken!.isEmpty) {
      throw Exception("Não foi possível obter o FCM Token");
    }
  }

  Future<Map<String, dynamic>> uploadAvatar(String file) async {
    UserModel user = await this.getUser();

    try {
      Response response = await api.dio.put(
        '${api.endpoint}/clients/avatar',
        data: {
          'file': "data:image/jpeg;base64,$file",
        },
      );
      var data = {
        'title': 'Foto de perfil alterada',
        'text': 'Sua foto de perfil foi alterada com sucesso!',
        'file': response.data['avatar']['url'],
      };
      user.avatarUrl = data['file'];

      await this.persistUser(user: user);
      return data;
    } catch (error) {
      print(error);
      throw api.handleError(error);
    }
  }
}
