import 'package:equatable/equatable.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StocksState extends Equatable {
  StocksState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedStocksState extends StocksState {
  @override
  String toString() => 'UninitializedStocksState';

  @override
  StocksState getStateCopy() => UninitializedStocksState();
}

class LoadingStocksState extends StocksState {
  @override
  String toString() => 'LoadingStocksState';

  @override
  StocksState getStateCopy() => LoadingStocksState();
}

class AddingStocksState extends StocksState {
  @override
  String toString() => 'AddingStocksState';

  @override
  StocksState getStateCopy() => AddingStocksState();
}

class DeletingStocksState extends StocksState {
  @override
  String toString() => 'DeletingStocksState';

  @override
  StocksState getStateCopy() => DeletingStocksState();
}

class ChangingStocksState extends StocksState {
  @override
  String toString() => 'ChangingStocksState';

  @override
  StocksState getStateCopy() => ChangingStocksState();
}

class LoadedStocksState extends StocksState {
  final List<StockModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedStocksState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedStocksState copyWith({
    List<StockModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedStocksState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedStocksState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  StocksState getStateCopy() => LoadedStocksState(
        items: this.items,
        hasReachedMax: this.hasReachedMax,
        page: this.page,
      );

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class AddedStocksState extends StocksState {
  final StockModel item;

  AddedStocksState({required this.item});

  AddedStocksState copyWith({StockModel? item}) =>
      AddedStocksState(item: item ?? this.item);

  @override
  String toString() => 'AddedStocksState { item: ${item.title} }';

  @override
  StocksState getStateCopy() => AddedStocksState(item: this.item);

  @override
  List<Object> get props => [item];
}

class DeletedStocksState extends StocksState {
  final StockModel item;

  DeletedStocksState({required this.item});

  DeletedStocksState copyWith({StockModel? item}) =>
      DeletedStocksState(item: item ?? this.item);

  @override
  String toString() => 'DeletedStocksState { item: ${item.title} }';

  @override
  StocksState getStateCopy() => DeletedStocksState(item: this.item);

  @override
  List<Object> get props => [item];
}

class ChangedStocksState extends StocksState {
  final StockModel item;

  ChangedStocksState({required this.item});

  ChangedStocksState copyWith({StockModel? item}) =>
      ChangedStocksState(item: item ?? this.item);

  @override
  String toString() => 'ChangedStocksState { item: ${item.title} }';

  @override
  StocksState getStateCopy() => ChangedStocksState(item: this.item);

  @override
  List<Object> get props => [item];
}

class ErrorStocksState extends StocksState {
  final String errorMessage;

  ErrorStocksState(this.errorMessage);

  @override
  String toString() => 'ErrorStocksState { ${this.errorMessage} }';

  @override
  StocksState getStateCopy() => ErrorStocksState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
