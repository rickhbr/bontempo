import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  UserState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedUserState extends UserState {
  @override
  String toString() => 'UninitializedUserState';

  @override
  UserState getStateCopy() {
    return UninitializedUserState();
  }
}

class LoadingUpdatePasswordState extends UserState {
  @override
  String toString() => 'LoadingUpdatePasswordState';

  @override
  UserState getStateCopy() {
    return LoadingUpdatePasswordState();
  }
}

class LoadedUpdatePasswordState extends UserState {
  @override
  String toString() => 'LoadedUpdatePasswordState';

  @override
  UserState getStateCopy() {
    return LoadedUpdatePasswordState();
  }
}

class ErrorUpdatePasswordState extends UserState {
  final String errorMessage;

  ErrorUpdatePasswordState(this.errorMessage);

  @override
  String toString() => 'ErrorUpdatePasswordState { ${this.errorMessage} }';

  @override
  UserState getStateCopy() {
    return ErrorUpdatePasswordState(this.errorMessage);
  }
}

class LoadingUpdateProfileState extends UserState {
  @override
  String toString() => 'LoadingUpdateProfileState';

  @override
  UserState getStateCopy() {
    return LoadingUpdateProfileState();
  }
}

class LoadedUpdateProfileState extends UserState {
  @override
  String toString() => 'LoadedUpdateProfileState';

  @override
  UserState getStateCopy() {
    return LoadedUpdateProfileState();
  }
}

class ErrorUpdateProfileState extends UserState {
  final String errorMessage;

  ErrorUpdateProfileState(this.errorMessage);

  @override
  String toString() => 'ErrorUpdateProfileState { ${this.errorMessage} }';

  @override
  UserState getStateCopy() {
    return ErrorUpdateProfileState(this.errorMessage);
  }
}
