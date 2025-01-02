import 'package:bontempo/models/look_model.dart';

class LookScheduleModel {
  final int id;
  final LookModel look;

  LookScheduleModel(
    this.id,
    this.look,
  );

  LookScheduleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        look = new LookModel.fromJson(json['look']);
}
