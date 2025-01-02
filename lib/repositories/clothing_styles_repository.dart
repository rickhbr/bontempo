import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/clothing_style_model.dart';
import 'package:bontempo/providers/api.dart';

class ClothingStylesRepository {
  static final ClothingStylesRepository _clothingStylesRepositorySingleton =
      ClothingStylesRepository._internal();
  factory ClothingStylesRepository() {
    return _clothingStylesRepositorySingleton;
  }
  ClothingStylesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  List<ClothingStyleModel> items = [];

  Future<List<ClothingStyleModel>> getClothingStyles() async {
    try {
      if (items.isEmpty) {
        Response response = await api.dio.get(
          '${api.endpoint}/clothing-styles',
        );
        items = List<ClothingStyleModel>.from(
          response.data['data']
              .map((style) => ClothingStyleModel.fromJson(style)),
        );
      }
      return items;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
