class WeatherModel {
  final int id;
  final String city;
  final String temperature;
  final String clouds;

  WeatherModel(
    this.id,
    this.city,
    this.temperature,
    this.clouds,
  );

  WeatherModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        city = json['city'] ?? '',
        temperature = json['temperature']?.toString() ?? '',
        clouds = json['clouds'] ?? '';
}
