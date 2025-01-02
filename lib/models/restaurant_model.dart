class RestaurantModel {
  final String id;
  final String title;
  final double latitude;
  final double longitude;

  RestaurantModel(
    this.id,
    this.title,
    this.latitude,
    this.longitude,
  );

  RestaurantModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['name'] ?? '',
        latitude = (json['location']['labeledLatLngs'] != null &&
                json['location']['labeledLatLngs'].isNotEmpty)
            ? json['location']['labeledLatLngs'][0]['lat'] ?? 0.0
            : 0.0,
        longitude = (json['location']['labeledLatLngs'] != null &&
                json['location']['labeledLatLngs'].isNotEmpty)
            ? json['location']['labeledLatLngs'][0]['lng'] ?? 0.0
            : 0.0;
}
