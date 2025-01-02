import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/providers/api.dart';

class RecipesRepository {
  static final RecipesRepository _recipesRepositorySingleton =
      new RecipesRepository._internal();
  factory RecipesRepository() {
    return _recipesRepositorySingleton;
  }
  RecipesRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getRecipes({
    int page = 1,
    int? idType,
    bool stockOnly = false,
  }) async {
    try {
      Map<String, dynamic> params = {'page': page};
      if (idType != null) {
        params['type'] = idType;
      }
      if (stockOnly == true) {
        params['considerIngredients'] = stockOnly;
      }
      Response response = await api.dio.get(
        '${api.endpoint}/recipes',
        queryParameters: params,
      );
      Map<String, dynamic> data = response.data;
      data['items'] = new List<RecipeModel>.from(
        data['data'].map((recipe) => new RecipeModel.fromJson(recipe)),
      );
      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<RecipeModel> getRecipeDetails({int? id}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpoint}/recipes/$id',
      );
      return new RecipeModel.fromJson(response.data);
    } catch (error) {
      throw api.handleError(error);
    }
  }

  Future<void> markAsDone({int? id}) async {
    try {
      await api.dio.post(
        '${api.endpoint}/recipes/$id/done',
      );
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
