import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/providers/api.dart';

class ClothingColorsRepository {
  static final ClothingColorsRepository _clothingColorsRepositorySingleton =
      ClothingColorsRepository._internal();
  factory ClothingColorsRepository() {
    return _clothingColorsRepositorySingleton;
  }
  ClothingColorsRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  List<ClothingColorModel> items = [];

  Future<List<ClothingColorModel>> getClothingColors() async {
    try {
      if (items.isEmpty) {
        Response response = await api.dio.get(
          '${api.endpoint}/clothing-colors',
        );
        items = List<ClothingColorModel>.from(
          response.data['data']
              .map((color) => ClothingColorModel.fromJson(color)),
        );
      }
      return items;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
