import 'package:bontempo/models/climate_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClimatesState extends Equatable {
  ClimatesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedClimatesState extends ClimatesState {
  @override
  String toString() => 'UninitializedClimatesState';

  @override
  ClimatesState getStateCopy() {
    return UninitializedClimatesState();
  }
}

class LoadingClimatesState extends ClimatesState {
  @override
  String toString() => 'LoadingClimatesState';

  @override
  ClimatesState getStateCopy() {
    return LoadingClimatesState();
  }
}

class LoadedClimatesState extends ClimatesState {
  final List<ClimateModel> items;

  LoadedClimatesState({required this.items});

  LoadedClimatesState copyWith({
    List<ClimateModel>? items,
  }) {
    return LoadedClimatesState(
      items: items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedClimatesState { items: ${items.length} }';

  @override
  ClimatesState getStateCopy() {
    return LoadedClimatesState(items: this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorClimatesState extends ClimatesState {
  final String errorMessage;

  ErrorClimatesState(this.errorMessage);

  @override
  String toString() => 'ErrorClimatesState { ${this.errorMessage} }';

  @override
  ClimatesState getStateCopy() {
    return ErrorClimatesState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
