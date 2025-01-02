import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/providers/api.dart';

class ClothingCategoriesRepository {
  static final ClothingCategoriesRepository
      _clothingCategoriesRepositorySingleton =
      ClothingCategoriesRepository._internal();
  factory ClothingCategoriesRepository() {
    return _clothingCategoriesRepositorySingleton;
  }
  ClothingCategoriesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  List<ClothingCategoryModel> items = [];

  Future<List<ClothingCategoryModel>> getClothingCategories() async {
    try {
      if (items.isEmpty) {
        Response response = await api.dio.get(
          '${api.endpoint}/clothing-categories',
        );
        items = List<ClothingCategoryModel>.from(
          response.data['data']
              .map((category) => ClothingCategoryModel.fromJson(category)),
        );
      }
      return items;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
