import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/home_look/index.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/repositories/look_repository.dart';

class HomeLookBloc extends Bloc<HomeLookEvent, HomeLookState> {
  HomeLookBloc() : super(UninitializedHomeLookState());

  @override
  Stream<HomeLookState> mapEventToState(
    HomeLookEvent event,
  ) async* {
    final currentState = state;
    LookRepository repository = LookRepository();

    if (event is SkipHomeLookEvent && currentState is! SkippingHomeLookState) {
      try {
        yield SkippingHomeLookState();
        List<ClothingModel> clothing = await repository.skipLook() ?? [];
        yield NewHomeLookState(clothing);
      } catch (error) {
        yield ErrorHomeLookState(error.toString());
      }
    }
    if (event is SaveHomeLookEvent && currentState is! SavingHomeLookState) {
      try {
        yield SavingHomeLookState();
        await repository.addLook(event.data);
        yield SavedHomeLookState('Look salvo com sucesso!');
      } catch (error) {
        yield ErrorHomeLookState(error.toString());
      }
    }
  }
}
