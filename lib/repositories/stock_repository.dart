import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/providers/api.dart';

class StockRepository {
  static final StockRepository _stockRepositorySingleton =
      new StockRepository._internal();
  factory StockRepository() {
    return _stockRepositorySingleton;
  }
  StockRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getStock({int page = 1}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/stock',
        queryParameters: {'page': page},
      );
      Map<String, dynamic> data = response.data;
      data['items'] = new List<StockModel>.from(
        data['data'].map((stock) => new StockModel.fromJson(stock)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<StockModel> insertStock({String? title, int quantity = 1}) async {
    try {
      Response response = await api.dio.post(
        '${api.endpoint}/stock',
        data: {
          'title': title,
          'quantity': quantity,
        },
      );
      return new StockModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<StockModel> updateStock({StockModel? item}) async {
    try {
      Response response = await api.dio.put(
        '${api.endpoint}/stock/${item!.id}',
        data: {
          'quantity': item.quantity,
          'title': item.title,
        },
      );
      return new StockModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<int> removeStock({int? id}) async {
    try {
      await api.dio.delete(
        '${api.endpoint}/stock/$id',
      );
      return id!;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
