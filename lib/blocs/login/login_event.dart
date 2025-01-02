import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final String email;
  final String password;

  DoLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'DoLogin { email: $email, password: $password }';
}

class SocialLogin extends LoginEvent {
  final String type;

  SocialLogin({required this.type});

  @override
  List<Object> get props => [type];

  @override
  String toString() => 'SocialLogin { type: $type }';
}

class RetrievePassword extends LoginEvent {
  final String email;

  RetrievePassword({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RetrievePassword { email: $email }';
}

class ToggleForm extends LoginEvent {
  final bool forgotForm;

  ToggleForm({required this.forgotForm});

  @override
  List<Object> get props => [forgotForm];

  @override
  String toString() => 'ToggleForm { forgotForm: $forgotForm }';
}
