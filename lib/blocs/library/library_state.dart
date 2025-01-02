import 'package:bontempo/models/library_folder_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LibraryState extends Equatable {
  LibraryState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedLibraryState extends LibraryState {
  @override
  String toString() => 'UninitializedLibraryState';

  @override
  LibraryState getStateCopy() {
    return UninitializedLibraryState();
  }
}

class LoadingLibraryState extends LibraryState {
  @override
  String toString() => 'LoadingLibraryState';

  @override
  LibraryState getStateCopy() {
    return LoadingLibraryState();
  }
}

class LoadedLibraryState extends LibraryState {
  final List<LibraryFolderModel> items;

  LoadedLibraryState(this.items);

  LoadedLibraryState copyWith({List<LibraryFolderModel>? items}) {
    return LoadedLibraryState(items ?? this.items);
  }

  @override
  String toString() => 'LoadedLibraryState { items: ${items.length} }';

  @override
  LibraryState getStateCopy() {
    return LoadedLibraryState(this.items);
  }

  @override
  List<Object> get props => [items];
}

class ErrorLibraryState extends LibraryState {
  final String errorMessage;

  ErrorLibraryState(this.errorMessage);

  @override
  String toString() => 'ErrorLibraryState { ${this.errorMessage} }';

  @override
  LibraryState getStateCopy() {
    return ErrorLibraryState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
