import 'package:equatable/equatable.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartState extends Equatable {
  CartState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedCartState extends CartState {
  @override
  String toString() => 'UninitializedCartState';

  @override
  CartState getStateCopy() => UninitializedCartState();
}

class LoadingCartState extends CartState {
  @override
  String toString() => 'LoadingCartState';

  @override
  CartState getStateCopy() => LoadingCartState();
}

class AddingCartState extends CartState {
  @override
  String toString() => 'AddingCartState';

  @override
  CartState getStateCopy() => AddingCartState();
}

class DeletingCartState extends CartState {
  @override
  String toString() => 'DeletingCartState';

  @override
  CartState getStateCopy() => DeletingCartState();
}

class ChangingCartState extends CartState {
  @override
  String toString() => 'ChangingCartState';

  @override
  CartState getStateCopy() => ChangingCartState();
}

class LoadedCartState extends CartState {
  final List<StockModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedCartState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedCartState copyWith({
    List<StockModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedCartState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedCartState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  CartState getStateCopy() => LoadedCartState(
        items: this.items,
        hasReachedMax: this.hasReachedMax,
        page: this.page,
      );

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class AddedCartState extends CartState {
  final StockModel item;

  AddedCartState({required this.item});

  AddedCartState copyWith({StockModel? item}) =>
      AddedCartState(item: item ?? this.item);

  @override
  String toString() => 'AddedCartState { item: ${item.title} }';

  @override
  CartState getStateCopy() => AddedCartState(item: this.item);

  @override
  List<Object> get props => [item];
}

class DeletedCartState extends CartState {
  final StockModel item;

  DeletedCartState({required this.item});

  DeletedCartState copyWith({StockModel? item}) =>
      DeletedCartState(item: item ?? this.item);

  @override
  String toString() => 'DeletedCartState { item: ${item.title} }';

  @override
  CartState getStateCopy() => DeletedCartState(item: this.item);

  @override
  List<Object> get props => [item];
}

class ChangedCartState extends CartState {
  final StockModel item;

  ChangedCartState({required this.item});

  ChangedCartState copyWith({StockModel? item}) =>
      ChangedCartState(item: item ?? this.item);

  @override
  String toString() => 'ChangedCartState { item: ${item.title} }';

  @override
  CartState getStateCopy() => ChangedCartState(item: this.item);

  @override
  List<Object> get props => [item];
}

class CheckedTotalCartState extends CartState {
  final int total;

  CheckedTotalCartState({required this.total});

  @override
  String toString() => 'CheckedTotalCartState { total: $total }';

  @override
  CartState getStateCopy() => CheckedTotalCartState(total: this.total);

  @override
  List<Object> get props => [total];
}

class ErrorCartState extends CartState {
  final String errorMessage;

  ErrorCartState(this.errorMessage);

  @override
  String toString() => 'ErrorCartState { $errorMessage }';

  @override
  CartState getStateCopy() => ErrorCartState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
