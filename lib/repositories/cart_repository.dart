import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/providers/api.dart';

class CartRepository {
  static final CartRepository _cartRepositorySingleton =
      new CartRepository._internal();
  factory CartRepository() {
    return _cartRepositorySingleton;
  }
  CartRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getCart({int page = 1}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/shopping-list',
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

  Future<StockModel> insertCart({String? title, int quantity = 1}) async {
    try {
      Response response = await api.dio.post(
        '${api.endpoint}/shopping-list',
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

  Future<StockModel> updateCart({StockModel? item}) async {
    try {
      Response response = await api.dio.put(
        '${api.endpoint}/shopping-list/${item!.id}',
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

  Future<int> removeCart({int? id}) async {
    try {
      await api.dio.delete(
        '${api.endpoint}/shopping-list/$id',
      );
      return id!;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
