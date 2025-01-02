import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/stores/index.dart';
import 'package:bontempo/repositories/store_repository.dart';

class StoreBloc extends Bloc<StoresEvent, StoreState> {
  StoreBloc() : super(UninitializedStoreState()) {
    on<LoadStoresEvent>(_onLoadStoresEvent);
  }

  Future<void> _onLoadStoresEvent(
      LoadStoresEvent event, Emitter<StoreState> emit) async {
    try {
      StoreRepository repository = StoreRepository();
      emit(LoadingStoreState());
      var store = await repository.getStores();
      emit(LoadedStoreState(store['items']));
    } catch (error) {
      emit(ErrorStoreState(error.toString()));
    }
  }
}
