class ClothingStyleModel {
  final int id;
  final String title;

  ClothingStyleModel(
    this.id,
    this.title,
  );

  ClothingStyleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];
}
