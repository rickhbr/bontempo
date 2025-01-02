import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final Map<String, dynamic> data;

  RegisterUser({required this.data});

  @override
  String toString() => 'RegisterUser { ${jsonEncode(this.data)} }';
}
