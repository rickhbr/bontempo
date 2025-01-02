import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdatePasswordEvent extends UserEvent {
  final String? password;
  final String? repeatPassword;
  UpdatePasswordEvent({this.password, this.repeatPassword});

  @override
  String toString() => 'UpdatePasswordEvent';
}

class UpdateProfileEvent extends UserEvent {
  final Map<String, dynamic> data;

  UpdateProfileEvent({required this.data});

  @override
  String toString() => 'UpdateProfileEvent { ${jsonEncode(this.data)} }';
}
