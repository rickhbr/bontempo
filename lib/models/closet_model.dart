import 'package:bontempo/models/closet_item_model.dart';

class ClosetModel {
  final List<ClosetItemModel> categories;
  final List<ClosetItemModel> colors;
  final List<ClosetItemModel> climates;

  ClosetModel(
    this.categories,
    this.colors,
    this.climates,
  );

  ClosetModel.fromJson(Map<String, dynamic> json)
      : categories = new List<ClosetItemModel>.from(
          json['categories']?.map(
                (item) => new ClosetItemModel.fromJson(item),
              ) ??
              [],
        ),
        colors = new List<ClosetItemModel>.from(
          json['colors']?.map(
                (item) => new ClosetItemModel.fromJson(item),
              ) ??
              [],
        ),
        climates = new List<ClosetItemModel>.from(
          json['climates']?.map(
                (item) => new ClosetItemModel.fromJson(item),
              ) ??
              [],
        );
}
