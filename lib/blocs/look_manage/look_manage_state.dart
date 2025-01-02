import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LookManageState extends Equatable {
  LookManageState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedLookManageState extends LookManageState {
  @override
  String toString() => 'UninitializedLookManageState';

  @override
  LookManageState getStateCopy() {
    return UninitializedLookManageState();
  }
}

class SendingLookManageState extends LookManageState {
  @override
  String toString() => 'SendingLookManageState';

  @override
  LookManageState getStateCopy() {
    return SendingLookManageState();
  }
}

class SentLookManageState extends LookManageState {
  final Map<String, dynamic> response;

  SentLookManageState(this.response);

  SentLookManageState copyWith({
    Map<String, dynamic>? response,
  }) {
    return SentLookManageState(
      response ?? this.response,
    );
  }

  @override
  String toString() => 'SentLookManageState';

  @override
  LookManageState getStateCopy() {
    return SentLookManageState(this.response);
  }
}

class ErrorLookManageState extends LookManageState {
  final String errorMessage;

  ErrorLookManageState(this.errorMessage);

  @override
  String toString() => 'ErrorLookManageState { ${this.errorMessage} }';

  @override
  LookManageState getStateCopy() {
    return ErrorLookManageState(this.errorMessage);
  }
}
