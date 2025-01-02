import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/repositories/library_repository.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(UninitializedLibraryState()) {
    on<LoadLibraryEvent>(_onLoadLibraryEvent);
  }

  Future<void> _onLoadLibraryEvent(
      LoadLibraryEvent event, Emitter<LibraryState> emit) async {
    try {
      LibraryRepository repository = LibraryRepository();
      emit(LoadingLibraryState());
      var library = await repository.getLibrary(
        search: event.search,
        folder: event.folder,
      );
      emit(LoadedLibraryState(library['items']));
    } catch (error) {
      emit(ErrorLibraryState(error.toString()));
    }
  }
}
