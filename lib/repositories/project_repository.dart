import 'dart:convert';

import 'package:bontempo/models/architects_model.dart';
import 'package:bontempo/models/environment_model.dart';
import 'package:bontempo/models/project_create_model.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';

class ProjectRepository {
  static final ProjectRepository _projectRepositorySingleton =
      ProjectRepository._internal();
  factory ProjectRepository() {
    return _projectRepositorySingleton;
  }
  ProjectRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getProjects({int? user, int? store}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpointMoodboard}/projects',
        queryParameters: {'user': user, 'store': store},
      );
      Map<String, dynamic> data = response.data;
      data['items'] = List<ProjectModel>.from(
        data['data']['projects'].map((looks) => ProjectModel.fromJson(looks)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<ProjectModel> create(ProjectCreateModel model) async {
    try {
      print('Enviando dados para a API: ${model.toJson()}');

      FormData formData = FormData.fromMap(model.toJson());

      Response response = await api.dio.post(
        'https://moodboard.bontempo.com.br/moodboard/api/projects/add',
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('Resposta da API: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data != null && response.data['data'] is List) {
          List<dynamic> dataList = response.data['data'];
          if (dataList.isNotEmpty) {
            var lastItem = dataList.last;
            print('Último item da lista de dados: $lastItem');
            try {
              var project = ProjectModel.fromJson(lastItem);
              print('Projeto criado: ${project.toJson()}');
              return project;
            } catch (e) {
              print('Erro ao converter JSON para ProjectModel: $e');
              throw e;
            }
          } else {
            throw Exception("Lista de dados vazia.");
          }
        } else {
          throw Exception("Resposta da API malformada.");
        }
      } else {
        print('================= ERROR =================');
        print('Status code: ${response.statusCode}');
        print('=========================================');
        print(response.data);
        throw Exception("Erro ao criar o projeto.");
      }
    } catch (error) {
      print('Erro ao criar projeto: $error');
      throw api.handleError(error);
    }
  }

  void _printLongString(String str) {
    const int chunkSize = 800;
    int startIndex = 0;
    while (startIndex < str.length) {
      int endIndex = startIndex + chunkSize;
      if (endIndex > str.length) endIndex = str.length;
      print(str.substring(startIndex, endIndex));
      startIndex = endIndex;
    }
  }

  Future<Map<String, dynamic>> architects() async {
    try {
      Response response = await api.dio.get(
        '${api.endpointMoodboard}/projects/architects',
      );
      Map<String, dynamic> data = response.data;
      data['items'] = List<ArchitectsModel>.from(
        data['data'].map((looks) => ArchitectsModel.fromJson(looks)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<Map<String, dynamic>> environments({int? user}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpointMoodboard}/projects/environments',
      );
      Map<String, dynamic> data = response.data;
      data['items'] = List<EnvironmentModel>.from(
        data['data'].map((looks) => EnvironmentModel.fromJson(looks)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
