import 'package:equatable/equatable.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LooksState extends Equatable {
  LooksState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedLooksState extends LooksState {
  @override
  String toString() => 'UninitializedLooksState';

  @override
  LooksState getStateCopy() {
    return UninitializedLooksState();
  }
}

class LoadingLooksState extends LooksState {
  @override
  String toString() => 'LoadingLooksState';

  @override
  LooksState getStateCopy() {
    return LoadingLooksState();
  }
}

class LoadedLooksState extends LooksState {
  final List<LookModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedLooksState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedLooksState copyWith({
    List<LookModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedLooksState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedLooksState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  LooksState getStateCopy() {
    return LoadedLooksState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class DeletingLookState extends LooksState {
  @override
  String toString() => 'DeletingLookState';

  @override
  LooksState getStateCopy() {
    return DeletingLookState();
  }
}

class DeletedLookState extends LooksState {
  final int idLook;

  DeletedLookState(this.idLook);

  DeletedLookState copyWith(int idLook) {
    return DeletedLookState(idLook);
  }

  @override
  String toString() => 'DeletedLookState { idLook: $idLook }';

  @override
  LooksState getStateCopy() {
    return DeletedLookState(idLook);
  }

  @override
  List<Object> get props => [idLook];
}

class ErrorLooksState extends LooksState {
  final String errorMessage;

  ErrorLooksState(this.errorMessage);

  @override
  String toString() => 'ErrorLooksState { ${this.errorMessage} }';

  @override
  LooksState getStateCopy() {
    return ErrorLooksState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
