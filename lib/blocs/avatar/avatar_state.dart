import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AvatarState extends Equatable {
  AvatarState getStateCopy();
  @override
  List<Object> get props => [];
}

class UnitializedAvatarState extends AvatarState {
  @override
  String toString() => 'UnitializedAvatarState';

  @override
  AvatarState getStateCopy() {
    return UnitializedAvatarState();
  }
}

class UploadingAvatarState extends AvatarState {
  @override
  String toString() => 'UploadingAvatarState';

  @override
  AvatarState getStateCopy() {
    return UploadingAvatarState();
  }
}

class UploadedAvatarState extends AvatarState {
  final Map<String, dynamic> response;

  UploadedAvatarState(this.response);

  @override
  String toString() =>
      'UploadedAvatarState { response: ${JsonEncoder().convert(this.response)} }';

  @override
  AvatarState getStateCopy() {
    return UploadedAvatarState(this.response);
  }
}

class ErrorAvatarState extends AvatarState {
  final String errorMessage;

  ErrorAvatarState(this.errorMessage);

  @override
  String toString() => 'ErrorAvatarState { error: ${this.errorMessage} }';

  @override
  AvatarState getStateCopy() {
    return ErrorAvatarState(this.errorMessage);
  }
}
