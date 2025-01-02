import 'package:bontempo/models/clothing_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeLookState extends Equatable {
  HomeLookState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedHomeLookState extends HomeLookState {
  @override
  String toString() => 'UninitializedHomeLookState';

  @override
  HomeLookState getStateCopy() {
    return UninitializedHomeLookState();
  }
}

class SkippingHomeLookState extends HomeLookState {
  @override
  String toString() => 'SkippingHomeLookState';

  @override
  HomeLookState getStateCopy() {
    return SkippingHomeLookState();
  }
}

class SavingHomeLookState extends HomeLookState {
  @override
  String toString() => 'SavingHomeLookState';

  @override
  HomeLookState getStateCopy() {
    return SavingHomeLookState();
  }
}

class NewHomeLookState extends HomeLookState {
  final List<ClothingModel> clothing;

  NewHomeLookState(this.clothing);

  NewHomeLookState copyWith({List<ClothingModel>? clothing}) {
    return NewHomeLookState(clothing ?? this.clothing);
  }

  @override
  String toString() => 'NewHomeLookState';

  @override
  HomeLookState getStateCopy() {
    return NewHomeLookState(this.clothing);
  }
}

class SavedHomeLookState extends HomeLookState {
  final String message;

  SavedHomeLookState(this.message);

  @override
  String toString() => 'SavedHomeLookState { ${this.message} }';

  @override
  HomeLookState getStateCopy() {
    return SavedHomeLookState(this.message);
  }
}

class ErrorHomeLookState extends HomeLookState {
  final String errorMessage;

  ErrorHomeLookState(this.errorMessage);

  @override
  String toString() => 'ErrorHomeLookState { ${this.errorMessage} }';

  @override
  HomeLookState getStateCopy() {
    return ErrorHomeLookState(this.errorMessage);
  }
}
