import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/closet/index.dart';
import 'package:bontempo/models/closet_model.dart';
import 'package:bontempo/repositories/closet_repository.dart';

class ClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  final ClosetRepository repository = ClosetRepository();

  ClosetBloc({ClosetState? initialState})
      : super(initialState ?? UninitializedClosetState()) {
    on<LoadClosetEvent>(_onLoadClosetEvent);
  }

  Future<void> _onLoadClosetEvent(
      LoadClosetEvent event, Emitter<ClosetState> emit) async {
    final currentState = state;
    if (currentState is! LoadingClosetState) {
      try {
        emit(LoadingClosetState());
        ClosetModel closet = await repository.getCloset();
        emit(LoadedClosetState(closet: closet));
      } catch (error) {
        emit(ErrorClosetState(error.toString()));
      }
    }
  }
}
