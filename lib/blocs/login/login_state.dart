import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  final String type;

  LoginLoading(this.type);

  @override
  String toString() => 'LoginLoading { type: $type }';
}

class LoginSuccess extends LoginState {
  @override
  String toString() => 'LoginSuccess';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  String toString() => 'LoginFailure { error: ${this.error} }';
}

class ForgotLoading extends LoginState {
  @override
  String toString() => 'ForgotLoading';
}

class ForgotSuccess extends LoginState {
  final String message;

  ForgotSuccess({required this.message});

  @override
  String toString() => 'ForgotSuccess: { message: $message }';
}

class ForgotFailure extends LoginState {
  final String error;

  ForgotFailure({required this.error});

  @override
  String toString() => 'ForgotFailure { error: ${this.error} }';
}

class LoginFormState extends LoginState {
  final bool forgotForm;

  LoginFormState({required this.forgotForm});

  @override
  String toString() => 'LoginFormState: { forgotForm: $forgotForm }';
}
