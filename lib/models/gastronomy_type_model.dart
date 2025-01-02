class GastronomyTypeListModel {
  List<GastronomyTypeModel> results;

  GastronomyTypeListModel({required this.results});

  GastronomyTypeListModel.fromJson(List<dynamic> json)
      : results = json.map((v) => GastronomyTypeModel.fromJson(v)).toList();
}

class GastronomyTypeModel {
  final int id;
  final String title;
  final String code;
  final String? thumbnail;

  GastronomyTypeModel(
    this.id,
    this.title,
    this.code,
    this.thumbnail,
  );

  GastronomyTypeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        code = json['code']?.toString() ?? '',
        thumbnail = json['thumbnail_info']?['url'];
}
