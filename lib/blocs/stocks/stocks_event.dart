import 'package:bontempo/models/stock_model.dart';
import 'package:equatable/equatable.dart';

abstract class StocksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStocksEvent extends StocksEvent {
  @override
  String toString() => 'LoadStocksEvent';
}

class AddStockEvent extends StocksEvent {
  final String title;
  final int quantity;

  AddStockEvent({required this.title, quantity})
      : this.quantity = quantity ?? 1;

  @override
  String toString() => 'AddStockEvent { title: $title, quantity: $quantity }';
}

class RemoveStockEvent extends StocksEvent {
  final StockModel? item;

  RemoveStockEvent({this.item});

  @override
  String toString() => 'RemoveStockEvent { id: ${item!.id} }';
}

class ChangeStockEvent extends StocksEvent {
  final StockModel? item;

  ChangeStockEvent({this.item});

  @override
  String toString() =>
      'ChangeStockEvent { id: ${item!.id}, quantity: ${item!.quantity} }';
}
