import 'package:bontempo/models/clothing_model.dart';

class LookModel {
  final int id;
  final String title;
  final List<ClothingModel>? clothing;

  LookModel(
    this.id,
    this.title,
    this.clothing,
  );

  LookModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        clothing = new List<ClothingModel>.from(
          json['clothing']
              .map((clothing) => new ClothingModel.fromJson(clothing)),
        );
}
