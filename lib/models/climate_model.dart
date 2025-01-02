class ClimateModel {
  final int id;
  final String title;
  final int minTemperature;
  final int maxTemperature;

  ClimateModel(
    this.id,
    this.title,
    this.minTemperature,
    this.maxTemperature,
  );

  ClimateModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        minTemperature = json['min_temperature'],
        maxTemperature = json['max_temperature'];
}
