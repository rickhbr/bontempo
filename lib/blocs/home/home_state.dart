import 'package:bontempo/models/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedHomeState extends HomeState {
  @override
  String toString() => 'UninitializedHomeState';

  @override
  HomeState getStateCopy() {
    return UninitializedHomeState();
  }
}

class LoadingHomeState extends HomeState {
  @override
  String toString() => 'LoadingHomeState';

  @override
  HomeState getStateCopy() {
    return LoadingHomeState();
  }
}

class LoadedHomeState extends HomeState {
  final HomeModel home;

  LoadedHomeState(this.home);

  LoadedHomeState copyWith({HomeModel? home}) {
    return LoadedHomeState(home ?? this.home);
  }

  @override
  String toString() => 'LoadedHomeState';

  @override
  HomeState getStateCopy() {
    return LoadedHomeState(this.home);
  }
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(this.errorMessage);

  @override
  String toString() => 'ErrorHomeState { ${this.errorMessage} }';

  @override
  HomeState getStateCopy() {
    return ErrorHomeState(this.errorMessage);
  }
}
