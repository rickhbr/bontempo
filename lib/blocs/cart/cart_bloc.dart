import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/cart/index.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/repositories/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository = CartRepository();

  CartBloc({CartState? initialState})
      : super(initialState ?? UninitializedCartState()) {
    on<CheckTotalCartEvent>(_onCheckTotalCartEvent);
    on<LoadCartEvent>(_onLoadCartEvent);
    on<AddCartEvent>(_onAddCartEvent);
    on<RemoveCartEvent>(_onRemoveCartEvent);
    on<ChangeCartEvent>(_onChangeCartEvent);
  }

  Future<void> _onCheckTotalCartEvent(
      CheckTotalCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingCartState());
      Map<String, dynamic> data = await repository.getCart(page: 1);
      emit(CheckedTotalCartState(total: data['total']));
    } catch (error) {
      emit(ErrorCartState(error.toString()));
    }
  }

  Future<void> _onLoadCartEvent(
      LoadCartEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingCartState) {
      try {
        if (currentState is UninitializedCartState) {
          emit(LoadingCartState());
          Map<String, dynamic> data = await repository.getCart(page: 1);
          emit(LoadedCartState(
            items: List<StockModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else if (currentState is LoadedCartState) {
          emit(LoadingCartState());
          Map<String, dynamic> data =
              await repository.getCart(page: currentState.page + 1);
          List<StockModel> items = List<StockModel>.from(data['items']);
          emit(items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LoadedCartState(
                  items: items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorCartState(error.toString()));
      }
    }
  }

  Future<void> _onAddCartEvent(
      AddCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(AddingCartState());
      StockModel item = await repository.insertCart(
        title: event.title,
        quantity: event.quantity,
      );
      emit(AddedCartState(item: item));
    } catch (error) {
      emit(ErrorCartState(error.toString()));
    }
  }

  Future<void> _onRemoveCartEvent(
      RemoveCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(DeletingCartState());
      await repository.removeCart(id: event.item!.id);
      emit(DeletedCartState(item: event.item!));
    } catch (error) {
      emit(ErrorCartState(error.toString()));
    }
  }

  Future<void> _onChangeCartEvent(
      ChangeCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(ChangingCartState());
      StockModel item = event.item!;
      await repository.updateCart(item: item);
      emit(ChangedCartState(item: item));
    } catch (error) {
      emit(ErrorCartState(error.toString()));
    }
  }

  bool _hasReachedMax(CartState state) =>
      state is LoadedCartState && state.hasReachedMax;
}
