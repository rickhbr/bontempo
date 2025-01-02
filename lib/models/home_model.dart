import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/models/restaurants_card_model.dart';
import 'package:bontempo/models/weather_model.dart';

class HomeModel {
  final String time;
  final HomeMode mode;
  final List<ClothingModel> clothing;
  final List<ClothingModel> scheduled;
  final RestaurantsCardModel? restaurantCard;
  final List<RecipeModel> recipes;
  final List<NewsModel> news;
  final MovieModel? movie;
  final WeatherModel? weather;

  HomeModel({
    required this.time,
    required this.mode,
    required this.clothing,
    required this.scheduled,
    this.restaurantCard,
    required this.recipes,
    required this.news,
    this.movie,
    this.weather,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      time: json['time'] ?? '',
      mode: json['layout'] == 'night' ? HomeMode.night : HomeMode.day,
      clothing: json['look'] != null
          ? List<ClothingModel>.from(
              json['look']
                      ?.map((clothing) => ClothingModel.fromJson(clothing)) ??
                  [],
            )
          : [],
      scheduled: json['schedule'] != null
          ? List<ClothingModel>.from(
              json['schedule']
                      ?.map((clothing) => ClothingModel.fromJson(clothing)) ??
                  [],
            )
          : [],
      restaurantCard: json['restaurants'] != null
          ? RestaurantsCardModel.fromJson(json['restaurants'])
          : null,
      recipes: json['recipes'] != null
          ? List<RecipeModel>.from(
              json['recipes']?.map((item) => RecipeModel.fromJson(item)) ?? [],
            )
          : [],
      news: json['news'] != null
          ? List<NewsModel>.from(
              json['news']?.map((item) => NewsModel.fromJson(item)) ?? [],
            )
          : [],
      movie: json['movie'] != null ? MovieModel.fromJson(json['movie']) : null,
      weather: json['weather'] != null
          ? WeatherModel.fromJson(json['weather'])
          : null,
    );
  }
}

enum HomeMode { day, night }
