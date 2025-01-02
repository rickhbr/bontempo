import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLibraryEvent extends LibraryEvent {
  String? search;
  String? folder;
  LoadLibraryEvent({this.search, this.folder});

  @override
  String toString() => 'LoadLibraryEvent';
}
