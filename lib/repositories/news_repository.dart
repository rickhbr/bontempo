import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:bontempo/providers/api.dart';

class NewsRepository {
  static final NewsRepository _newsRepositorySingleton =
      new NewsRepository._internal();
  factory NewsRepository() {
    return _newsRepositorySingleton;
  }
  NewsRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getNews({int page = 1}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/news',
        queryParameters: {'page': page},
      );
      Map<String, dynamic> data = response.data;
      data['items'] = new List<NewsModel>.from(
        data['data'].map((news) => new NewsModel.fromJson(news)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
