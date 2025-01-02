class LookCalendarModel {
  final int total;
  final String day;
  final String month;
  final String year;
  final String date;

  LookCalendarModel(
    this.total,
    this.day,
    this.month,
    this.year,
    this.date,
  );

  LookCalendarModel.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        day = json['computed_day'],
        month = json['computed_month'],
        year = json['computed_year'],
        date = json['date'];
}
