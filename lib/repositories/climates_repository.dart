import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/climate_model.dart';
import 'package:bontempo/providers/api.dart';

class ClimatesRepository {
  static final ClimatesRepository _climatesRepositorySingleton =
      ClimatesRepository._internal();
  factory ClimatesRepository() {
    return _climatesRepositorySingleton;
  }
  ClimatesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  List<ClimateModel> items = [];

  Future<List<ClimateModel>> getClimates() async {
    try {
      if (items.isEmpty) {
        Response response = await api.dio.get(
          '${api.endpoint}/climates',
        );
        items = List<ClimateModel>.from(
          response.data['data']
              .map((climate) => ClimateModel.fromJson(climate)),
        );
      }
      return items;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
