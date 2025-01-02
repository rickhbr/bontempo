import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/models/store_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StoreState extends Equatable {
  StoreState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedStoreState extends StoreState {
  @override
  String toString() => 'UninitializedStoreState';

  @override
  StoreState getStateCopy() {
    return UninitializedStoreState();
  }
}

class LoadingStoreState extends StoreState {
  @override
  String toString() => 'LoadingStoreState';

  @override
  StoreState getStateCopy() {
    return LoadingStoreState();
  }
}

class LoadedStoreState extends StoreState {
  final List<StoreModel> items;

  LoadedStoreState(this.items);

  LoadedStoreState copyWith({List<StoreModel>? items}) {
    return LoadedStoreState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedStoreState';

  @override
  StoreState getStateCopy() {
    return LoadedStoreState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorStoreState extends StoreState {
  final String errorMessage;

  ErrorStoreState(this.errorMessage);

  @override
  String toString() => 'ErrorStoreState { ${this.errorMessage} }';

  @override
  StoreState getStateCopy() {
    return ErrorStoreState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
