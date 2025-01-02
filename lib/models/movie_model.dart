class MovieModel {
  final int id;
  final String title;
  final String code;
  final String rating;
  final String thumbnail;
  final String url;
  final bool watched;

  MovieModel({
    required this.id,
    required this.title,
    required this.code,
    required this.rating,
    required this.thumbnail,
    required this.url,
    required this.watched,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      code: json['code']?.toString() ?? '',
      rating: json['rating']?.toString() ?? '',
      thumbnail: json['poster'] ?? '',
      url: json['url'] ?? '',
      watched: json['watched'] != null && json['watched'] > 0,
    );
  }
}
