import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GastronomyTypesState extends Equatable {
  GastronomyTypesState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedGastronomyTypesState extends GastronomyTypesState {
  @override
  String toString() => 'UninitializedGastronomyTypesState';

  @override
  GastronomyTypesState getStateCopy() {
    return UninitializedGastronomyTypesState();
  }
}

class LoadingGastronomyTypesState extends GastronomyTypesState {
  @override
  String toString() => 'LoadingGastronomyTypesState';

  @override
  GastronomyTypesState getStateCopy() {
    return LoadingGastronomyTypesState();
  }
}

class LoadedGastronomyTypesState extends GastronomyTypesState {
  final List<GastronomyTypeModel> items;

  LoadedGastronomyTypesState(this.items);

  LoadedGastronomyTypesState copyWith({
    List<GastronomyTypeModel>? items,
  }) {
    return LoadedGastronomyTypesState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedGastronomyTypesState { items: ${items.length} }';

  @override
  GastronomyTypesState getStateCopy() {
    return LoadedGastronomyTypesState(this.items);
  }
}

class SavingGastronomyTypesState extends GastronomyTypesState {
  @override
  String toString() => 'SavingGastronomyTypesState';

  @override
  GastronomyTypesState getStateCopy() {
    return SavingGastronomyTypesState();
  }
}

class SavedGastronomyTypesState extends GastronomyTypesState {
  final Map<String, dynamic> response;

  SavedGastronomyTypesState(this.response);

  @override
  String toString() =>
      'SavedGastronomyTypesState { response: ${jsonEncode(this.response)} }';

  @override
  GastronomyTypesState getStateCopy() {
    return SavedGastronomyTypesState(this.response);
  }
}

class LoadingClientGastronomyTypesState extends GastronomyTypesState {
  @override
  String toString() => 'LoadingClientGastronomyTypesState';

  @override
  GastronomyTypesState getStateCopy() {
    return LoadingClientGastronomyTypesState();
  }
}

class LoadedClientGastronomyTypesState extends GastronomyTypesState {
  final List<GastronomyTypeModel> items;

  LoadedClientGastronomyTypesState(this.items);

  LoadedClientGastronomyTypesState copyWith({
    List<GastronomyTypeModel>? items,
  }) {
    return LoadedClientGastronomyTypesState(
      items ?? this.items,
    );
  }

  @override
  String toString() => 'LoadedGastronomyTypesState { items: ${items.length} }';

  @override
  GastronomyTypesState getStateCopy() {
    return LoadedGastronomyTypesState(this.items);
  }
}

class ErrorGastronomyTypesState extends GastronomyTypesState {
  final String errorMessage;

  ErrorGastronomyTypesState(this.errorMessage);

  @override
  String toString() => 'ErrorGastronomyTypesState { ${this.errorMessage} }';

  @override
  GastronomyTypesState getStateCopy() {
    return ErrorGastronomyTypesState(this.errorMessage);
  }
}

class CheckedGastronomyTypesState extends GastronomyTypesState {
  final bool selected;

  CheckedGastronomyTypesState(this.selected);

  @override
  String toString() =>
      'CheckedGastronomyTypesState { valid: ${this.selected} }';

  @override
  GastronomyTypesState getStateCopy() {
    return CheckedGastronomyTypesState(this.selected);
  }
}
