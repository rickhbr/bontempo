import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/looks/index.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/repositories/look_repository.dart';

class LooksBloc extends Bloc<LooksEvent, LooksState> {
  final LookRepository repository = LookRepository();

  LooksBloc() : super(UninitializedLooksState()) {
    on<LoadLooksEvent>(_onLoadLooksEvent);
    on<ResetLooksEvent>(_onResetLooksEvent);
    on<DeleteLookEvent>(_onDeleteLookEvent);
  }

  void _onLoadLooksEvent(LoadLooksEvent event, Emitter<LooksState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingLooksState) {
      try {
        if (currentState is UninitializedLooksState) {
          emit(LoadingLooksState());
          Map<String, dynamic> data = await repository.getLooks(
            page: 1,
          );
          emit(LoadedLooksState(
            items: List<LookModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else {
          var state = currentState as LoadedLooksState;
          emit(LoadingLooksState());
          Map<String, dynamic> data = await repository.getLooks(
            page: state.page + 1,
          );

          List<LookModel> items = List<LookModel>.from(data['items']);
          emit(items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedLooksState(
                  items: items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorLooksState(error.toString()));
      }
    }
  }

  void _onResetLooksEvent(ResetLooksEvent event, Emitter<LooksState> emit) {
    emit(UninitializedLooksState());
  }

  void _onDeleteLookEvent(
      DeleteLookEvent event, Emitter<LooksState> emit) async {
    try {
      emit(DeletingLookState());
      int idLook = await repository.deleteLook(event.idLook);
      emit(DeletedLookState(idLook));
    } catch (error) {
      emit(ErrorLooksState(error.toString()));
    }
  }

  bool _hasReachedMax(LooksState state) =>
      state is LoadedLooksState && state.hasReachedMax;
}
