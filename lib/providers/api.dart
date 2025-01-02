import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/blocs/authentication/index.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/env.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/repositories/user_repository.dart';

class ApiProvider {
  final String _endpoint = environment['baseUrl'] ?? '';
  final String _endpointMoodboard = environment['baseUrlMoodboard'] ?? '';
  final String _token = environment['token'] ?? '';
  final Dio _dio = Dio();

  String get endpoint => _endpoint;
  String get endpointMoodboard => _endpointMoodboard;
  Dio get dio => _dio;

  ApiProvider() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          UserRepository userRepository = UserRepository();
          options.headers["Accept"] = 'application/json';
          options.headers["api-token"] = _token;
          options.headers["Content-Type"] = 'application/json';
          String? _bearer = await userRepository.getToken();
          if (_bearer != null) {
            options.headers["Authorization"] = 'Bearer $_bearer';
          }
          return handler.next(options);
        },
      ),
    );
  }

  String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioError) {
      print('================= ERROR =================');
      print('DioError: ${error.message}');
      print('Type: ${error.type}');
      print('Response data: ${error.response?.data}');
      print('=========================================');

      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "A requisição foi cancelada.";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Tempo limite de conexão com a API esgotada.";
          break;
        case DioErrorType.unknown:
          errorDescription =
              "Não foi possível detectar nenhuma conexão com a internet. Verifique e tente novamente.";
          // Testa conexão:
          InternetAddress.lookup('google.com').catchError((err) {
            if (!error.requestOptions.path.contains('auth/login')) {
              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                NoConnectionViewRoute,
                (Route<dynamic> route) => false,
              );
            }
          });
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Tempo limite de resposta com a API esgotada.";
          break;
        case DioErrorType.badResponse:
          print('================= ERROR =================');
          print('Status code: ${error.response?.statusCode}');
          print('=========================================');
          print(error.response?.data);
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains('auth/login')) {
            getIt.get<AuthenticationBloc>().add(LoggedOut());
          }
          if (error.response?.statusCode == 413) {
            errorDescription = "O arquivo é muito grande.";
          } else {
            print(error.response?.statusCode);
            errorDescription =
                "Ocorreu um erro com a sua requisição, por favor tente novamente.";
            if (error.response?.data['error'] != null &&
                error.response?.data['error']['message'] != null) {
              errorDescription = error.response?.data['error']['message'];
            } else if (error.response?.data['message'] != null &&
                error.response?.data['message'] != null) {
              errorDescription = error.response?.data['message'];
            }
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Tempo de limite de envio esgotado.";
          break;
        case DioErrorType.badCertificate:
          errorDescription = "Certificado inválido.";
          break;
        default:
          errorDescription =
              "Ocorreu um erro desconhecido. Por favor, tente novamente.";
          break;
      }
    } else {
      print('================= ERROR =================');
      print('O erro é: $error');
      print('=========================================');
      errorDescription =
          "Ocorreu um erro com a sua requisição, por favor tente novamente.";
    }
    return errorDescription;
  }
}
