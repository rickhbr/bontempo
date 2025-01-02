class NotificationModel {
  final int id;
  final String title;
  final String text;
  final String code;
  final String dateTime;
  final Map<String, dynamic> data;

  NotificationModel(
    this.id,
    this.title,
    this.text,
    this.code,
    this.dateTime,
    this.data,
  );

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        code = json['code'],
        dateTime = json['dateTime'],
        data = json['data'];
}
