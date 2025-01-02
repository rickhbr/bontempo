import 'package:bontempo/models/restaurant_model.dart';

class RestaurantsCardModel {
  final String title;
  final String photo;
  final List<RestaurantModel> restaurants;

  RestaurantsCardModel(
    this.title,
    this.photo,
    this.restaurants,
  );

  RestaurantsCardModel.fromJson(Map<String, dynamic> json)
      : title = json['type']['title'] ?? '',
        photo = json['type']['thumbnail'] ?? '',
        restaurants = List<RestaurantModel>.from(
          json['restaurants'] != null
              ? json['restaurants']?.map(
                    (item) => RestaurantModel.fromJson(item),
                  ) ??
                  []
              : [],
        );
}
