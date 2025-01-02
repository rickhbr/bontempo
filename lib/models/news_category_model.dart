class NewsCategoryModel {
  final int id;
  final String title;
  final String code;

  NewsCategoryModel({
    required this.id,
    required this.title,
    required this.code,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewsCategoryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      code: json['code']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
    };
  }
}
