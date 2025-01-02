import 'package:bontempo/models/closet_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClosetState extends Equatable {
  ClosetState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClosetState extends ClosetState {
  @override
  String toString() => 'UninitializedClosetState';

  @override
  ClosetState getStateCopy() {
    return UninitializedClosetState();
  }
}

class LoadingClosetState extends ClosetState {
  @override
  String toString() => 'LoadingClosetState';

  @override
  ClosetState getStateCopy() {
    return LoadingClosetState();
  }
}

class LoadedClosetState extends ClosetState {
  final ClosetModel closet;

  LoadedClosetState({required this.closet});

  LoadedClosetState copyWith({ClosetModel? closet}) {
    return LoadedClosetState(closet: closet ?? this.closet);
  }

  @override
  String toString() => 'LoadedClosetState { closet: ${closet.toString()} }';

  @override
  ClosetState getStateCopy() {
    return LoadedClosetState(closet: this.closet);
  }

  @override
  List<Object> get props => [closet];
}

class ErrorClosetState extends ClosetState {
  final String errorMessage;

  ErrorClosetState(this.errorMessage);

  @override
  String toString() => 'ErrorClosetState { $errorMessage }';

  @override
  ClosetState getStateCopy() {
    return ErrorClosetState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
