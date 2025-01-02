import 'package:flutter/material.dart';

class ClothingColorModel {
  final int id;
  final String title;
  final Color color;

  ClothingColorModel(
    this.id,
    this.title,
    this.color,
  );

  ClothingColorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        color =
            Color(int.parse('0xFF${json['color'].toString().substring(1)}'));
}
