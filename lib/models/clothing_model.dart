import 'package:bontempo/models/clothing_category_model.dart';

class ClothingModel {
  final int id;
  final int appreciation;
  final String picture;
  final bool isMain;
  final List<Placement> placements;
  final List<int> idClimates;
  final int idColor;
  final int idCategory;
  final int idStyle;

  ClothingModel(
    this.id,
    this.appreciation,
    this.picture,
    this.isMain,
    this.placements,
    this.idClimates,
    this.idColor,
    this.idCategory,
    this.idStyle,
  );

  ClothingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        appreciation = json['appreciation'] is String
            ? int.tryParse(json['appreciation']) ?? 0
            : json['appreciation'] ?? 0,
        picture = json['picture'] is Map
            ? json['picture']['url'] ?? ''
            : json['picture'] ?? '',
        isMain = json['is_main'] ??
            (json['category'] != null
                ? json['category']['is_main'] ?? false
                : false),
        placements = json['placements'] != null && json['placements'].isNotEmpty
            ? List.from(json['placements'].map((item) {
                switch (item['slug']) {
                  case 'head':
                    return Placement.head;
                  case 'neck':
                    return Placement.neck;
                  case 'torso':
                    return Placement.torso;
                  case 'belt':
                    return Placement.belt;
                  case 'legs':
                    return Placement.legs;
                  case 'feet':
                    return Placement.feet;
                  case 'hands':
                    return Placement.hands;
                  default:
                    return Placement.accessories;
                }
              }))
            : List.empty(),
        idClimates = json['climates'] != null
            ? List<int>.from(json['climates'].map((dynamic item) =>
                item['id'] is String
                    ? int.tryParse(item['id']) ?? 0
                    : item['id']))
            : [],
        idCategory = json['category_id'] is String
            ? int.tryParse(json['category_id']) ?? 0
            : json['category_id'] ?? 0,
        idColor = json['color_id'] is String
            ? int.tryParse(json['color_id']) ?? 0
            : json['color_id'] ?? 0,
        idStyle = json['style_id'] is String
            ? int.tryParse(json['style_id']) ?? 0
            : json['style_id'] ?? 0;
}
