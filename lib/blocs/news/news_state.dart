import 'package:equatable/equatable.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsState extends Equatable {
  NewsState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedNewsState extends NewsState {
  @override
  String toString() => 'UninitializedNewsState';

  @override
  NewsState getStateCopy() {
    return UninitializedNewsState();
  }
}

class LoadingNewsState extends NewsState {
  @override
  String toString() => 'LoadingNewsState';

  @override
  NewsState getStateCopy() {
    return LoadingNewsState();
  }
}

class LoadedNewsState extends NewsState {
  final List<NewsModel> items;
  final bool hasReachedMax;
  final int page;

  LoadedNewsState({
    required this.items,
    required this.hasReachedMax,
    required this.page,
  });

  LoadedNewsState copyWith({
    List<NewsModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedNewsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedNewsState { items: ${items.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  NewsState getStateCopy() {
    return LoadedNewsState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax, page];
}

class ErrorNewsState extends NewsState {
  final String errorMessage;

  ErrorNewsState(this.errorMessage);

  @override
  String toString() => 'ErrorNewsState { $errorMessage }';

  @override
  NewsState getStateCopy() {
    return ErrorNewsState(this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
