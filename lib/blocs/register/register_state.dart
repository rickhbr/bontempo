import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => 'RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';
}

class RegisterSuccess extends RegisterState {
  @override
  String toString() => 'RegisterSuccess';
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});

  @override
  String toString() => 'RegisterFailure { error: ${this.error} }';
}
