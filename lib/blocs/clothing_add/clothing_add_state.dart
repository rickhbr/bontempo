import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClothingAddState extends Equatable {
  ClothingAddState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClothingAddState extends ClothingAddState {
  @override
  String toString() => 'UninitializedClothingAddState';

  @override
  ClothingAddState getStateCopy() {
    return UninitializedClothingAddState();
  }
}

class SendingClothingAddState extends ClothingAddState {
  @override
  String toString() => 'SendingClothingAddState';

  @override
  ClothingAddState getStateCopy() {
    return SendingClothingAddState();
  }
}

class SentClothingAddState extends ClothingAddState {
  final Map<String, dynamic> response;

  SentClothingAddState(this.response);

  SentClothingAddState copyWith({
    Map<String, dynamic>? response,
  }) {
    return SentClothingAddState(
      response ?? this.response,
    );
  }

  @override
  String toString() => 'SentClothingAddState { response: $response }';

  @override
  ClothingAddState getStateCopy() {
    return SentClothingAddState(this.response);
  }

  @override
  List<Object> get props => [response];
}

class ErrorClothingAddState extends ClothingAddState {
  final String errorMessage;

  ErrorClothingAddState(this.errorMessage);

  @override
  String toString() => 'ErrorClothingAddState { ${this.errorMessage} }';

  @override
  ClothingAddState getStateCopy() {
    return ErrorClothingAddState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
