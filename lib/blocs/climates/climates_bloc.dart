import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/climates/index.dart';
import 'package:bontempo/models/climate_model.dart';
import 'package:bontempo/repositories/climates_repository.dart';

class ClimatesBloc extends Bloc<ClimatesEvent, ClimatesState> {
  final ClimatesRepository repository = ClimatesRepository();

  ClimatesBloc({ClimatesState? initialState})
      : super(initialState ?? UninitializedClimatesState()) {
    on<LoadClimatesEvent>(_onLoadClimatesEvent);
  }

  void _onLoadClimatesEvent(
      LoadClimatesEvent event, Emitter<ClimatesState> emit) async {
    if (state is! LoadingClimatesState) {
      try {
        emit(LoadingClimatesState());
        List<ClimateModel> items = await repository.getClimates();
        emit(LoadedClimatesState(items: items));
      } catch (error) {
        emit(ErrorClimatesState(error.toString()));
      }
    }
  }
}
