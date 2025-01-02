class RecipeModel {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final List<IngredientModel> ingredients;
  final String information;
  final String preparation;
  final String video;
  final String videoThumb;

  RecipeModel(
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.ingredients,
    this.information,
    this.preparation,
    this.video,
    this.videoThumb,
  );

  RecipeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        thumbnail = (json['thumbnail_info'] != null &&
                json['thumbnail_info']['url'] != null)
            ? json['thumbnail_info']['url']
            : '',
        ingredients = List<IngredientModel>.from(
          json['ingredients']?.map(
                (item) => IngredientModel.fromJson(item),
              ) ??
              [],
        ),
        information = json['information'] ?? '',
        preparation = json['preparation'] ?? '',
        video = json['video'] ?? '',
        videoThumb = json['videoThumb'] ?? '';
}

class IngredientModel {
  final int id;
  final String title;

  IngredientModel(
    this.id,
    this.title,
  );

  IngredientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? '';
}
