import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/stocks/index.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/repositories/stock_repository.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final StockRepository repository = StockRepository();

  StocksBloc() : super(UninitializedStocksState()) {
    on<LoadStocksEvent>(_onLoadStocksEvent);
    on<AddStockEvent>(_onAddStockEvent);
    on<RemoveStockEvent>(_onRemoveStockEvent);
    on<ChangeStockEvent>(_onChangeStockEvent);
  }

  void _onLoadStocksEvent(
      LoadStocksEvent event, Emitter<StocksState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingStocksState) {
      try {
        if (currentState is UninitializedStocksState) {
          emit(LoadingStocksState());
          Map<String, dynamic> data = await repository.getStock(
            page: 1,
          );
          emit(LoadedStocksState(
            items: List<StockModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else {
          var state = currentState as LoadedStocksState;
          emit(LoadingStocksState());
          Map<String, dynamic> data = await repository.getStock(
            page: state.page + 1,
          );

          List<StockModel> items = List<StockModel>.from(data['items']);
          emit(items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedStocksState(
                  items: items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorStocksState(error.toString()));
      }
    }
  }

  void _onAddStockEvent(AddStockEvent event, Emitter<StocksState> emit) async {
    try {
      emit(AddingStocksState());
      StockModel item = await repository.insertStock(
        title: event.title,
        quantity: event.quantity,
      );
      emit(AddedStocksState(item: item));
    } catch (error) {
      emit(ErrorStocksState(error.toString()));
    }
  }

  void _onRemoveStockEvent(
      RemoveStockEvent event, Emitter<StocksState> emit) async {
    try {
      emit(DeletingStocksState());
      await repository.removeStock(
        id: event.item!.id,
      );
      emit(DeletedStocksState(item: event.item!));
    } catch (error) {
      emit(ErrorStocksState(error.toString()));
    }
  }

  void _onChangeStockEvent(
      ChangeStockEvent event, Emitter<StocksState> emit) async {
    try {
      emit(ChangingStocksState());
      StockModel item = event.item!;
      await repository.updateStock(
        item: item,
      );
      emit(ChangedStocksState(item: item));
    } catch (error) {
      emit(ErrorStocksState(error.toString()));
    }
  }

  bool _hasReachedMax(StocksState state) =>
      state is LoadedStocksState && state.hasReachedMax;
}
