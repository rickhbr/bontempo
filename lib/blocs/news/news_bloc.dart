import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/news/index.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:bontempo/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository = NewsRepository();

  NewsBloc() : super(UninitializedNewsState()) {
    on<LoadNewsEvent>(_onLoadNewsEvent);
    on<ResetNewsEvent>(_onResetNewsEvent);
  }

  Future<void> _onLoadNewsEvent(
      LoadNewsEvent event, Emitter<NewsState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState) && currentState is! LoadingNewsState) {
      try {
        if (currentState is UninitializedNewsState) {
          emit(LoadingNewsState());
          Map<String, dynamic> data = await repository.getNews(page: 1);
          emit(LoadedNewsState(
            items: List<NewsModel>.from(data['items']),
            hasReachedMax: data['page'] >= data['lastPage'],
            page: data['page'],
          ));
        } else if (currentState is LoadedNewsState) {
          emit(LoadingNewsState());
          Map<String, dynamic> data =
              await repository.getNews(page: currentState.page + 1);

          List<NewsModel> items = List<NewsModel>.from(data['items']);
          emit(items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LoadedNewsState(
                  items: currentState.items + items,
                  hasReachedMax: data['page'] >= data['lastPage'],
                  page: data['page'],
                ));
        }
      } catch (error) {
        emit(ErrorNewsState(error.toString()));
      }
    }
  }

  void _onResetNewsEvent(ResetNewsEvent event, Emitter<NewsState> emit) {
    emit(UninitializedNewsState());
  }

  bool _hasReachedMax(NewsState state) =>
      state is LoadedNewsState && state.hasReachedMax;
}
