import 'package:flutter/material.dart';

class ClosetItemModel {
  final int id;
  final String title;
  final String image;
  final Color? color;
  final int total;
  final int percent;

  ClosetItemModel(
    this.id,
    this.title,
    this.image,
    this.color,
    this.total,
    this.percent,
  );

  ClosetItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = json['image'],
        color = json['color'] != null ? Color(int.parse('0xFF${json['color'].toString().substring(1)}')) : null,
        total = json['total'],
        percent = json['percent'];
}
