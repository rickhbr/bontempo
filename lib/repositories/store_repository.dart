import 'package:bontempo/models/store_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';

class StoreRepository {
  static final StoreRepository _storeRepositorySingleton =
      StoreRepository._internal();
  factory StoreRepository() {
    return _storeRepositorySingleton;
  }
  StoreRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getStores({int page = 1}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpointMoodboard}/stores',
        //queryParameters: {'page': page},
      );

      print('API do Moodboard ${api.endpointMoodboard}/stores');
      print(response.data);
      Map<String, dynamic> data = response.data;
      data['items'] = List<StoreModel>.from(
        data['data']['stores'].map((store) => StoreModel.fromJson(store)),
      );
      print('resposta: $data');
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
