class EventModel {
  final String id;
  final String title;
  final String hour;

  EventModel(
    this.id,
    this.title,
    this.hour,
  );

  EventModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['summary'],
        hour = json['start']['dateTime'] != null
            ? json['start']['dateTime'].substring(11, 16)
            : null;
}
