class MovieGenreListModel {
  List<MovieGenreModel> results;

  MovieGenreListModel({required this.results});

  factory MovieGenreListModel.fromJson(List<dynamic> json) {
    return MovieGenreListModel(
      results: json.map((v) => MovieGenreModel.fromJson(v)).toList(),
    );
  }
}

class MovieGenreModel {
  final int id;
  final String title;
  final String code;

  MovieGenreModel({
    required this.id,
    required this.title,
    required this.code,
  });

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) {
    return MovieGenreModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      code: json['code']?.toString() ?? '',
    );
  }
}
