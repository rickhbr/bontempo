import 'package:bontempo/models/stock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  @override
  String toString() => 'LoadCartEvent';
}

class CheckTotalCartEvent extends CartEvent {
  @override
  String toString() => 'CheckTotalCartEvent';
}

class AddCartEvent extends CartEvent {
  final String title;
  final int quantity;

  AddCartEvent({required this.title, quantity}) : this.quantity = quantity ?? 1;

  @override
  String toString() => 'AddCartEvent { title: $title, quantity: $quantity }';
}

class ChangeCartEvent extends CartEvent {
  final StockModel? item;

  ChangeCartEvent({this.item});

  @override
  String toString() =>
      'ChangeCartEvent { id: ${item!.id}, quantity: ${item!.quantity} }';
}

class RemoveCartEvent extends CartEvent {
  final StockModel? item;

  RemoveCartEvent({this.item});

  @override
  String toString() => 'RemoveCartEvent { id: ${item!.id} }';
}
