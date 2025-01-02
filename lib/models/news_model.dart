class NewsModel {
  final int id;
  final String title;
  final String date;
  final String description;
  final String thumbnail;
  final String url;

  NewsModel(
    this.id,
    this.title,
    this.date,
    this.description,
    this.thumbnail,
    this.url,
  );

  NewsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? '',
        date = json['created_at'] ?? '',
        description = json['description'] ?? '',
        thumbnail = json['image'] ?? '',
        url = json['url'] ?? '';
}
