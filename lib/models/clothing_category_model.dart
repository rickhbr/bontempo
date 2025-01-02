enum Placement { head, neck, torso, belt, legs, feet, hands, accessories }

class ClothingCategoryModel {
  final int id;
  final String title;
  final bool isMain;
  final List<Placement> placements;

  ClothingCategoryModel(
    this.id,
    this.title,
    this.isMain,
    this.placements,
  );

  ClothingCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? '',
        isMain = json['isMain'] ?? false,
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
                  case 'feet':
                    return Placement.feet;
                  case 'hands':
                    return Placement.hands;
                  default:
                    return Placement.accessories;
                }
              }))
            : List.empty();
}
