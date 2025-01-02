import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/look_manage/index.dart';
import 'package:bontempo/repositories/look_repository.dart';

class LookManageBloc extends Bloc<LookManageEvent, LookManageState> {
  final LookRepository repository = LookRepository();

  LookManageBloc() : super(UninitializedLookManageState()) {
    on<AddLookEvent>(_onAddLookEvent);
    on<EditLookEvent>(_onEditLookEvent);
  }

  Future<void> _onAddLookEvent(
      AddLookEvent event, Emitter<LookManageState> emit) async {
    try {
      emit(SendingLookManageState());
      Map<String, dynamic> response = await repository.addLook(event.data);
      emit(SentLookManageState(response));
    } catch (error) {
      emit(ErrorLookManageState(error.toString()));
    }
  }

  Future<void> _onEditLookEvent(
      EditLookEvent event, Emitter<LookManageState> emit) async {
    try {
      emit(SendingLookManageState());
      Map<String, dynamic> response = await repository.editLook(
        event.id,
        event.data,
      );
      emit(SentLookManageState(response));
    } catch (error) {
      emit(ErrorLookManageState(error.toString()));
    }
  }
}
