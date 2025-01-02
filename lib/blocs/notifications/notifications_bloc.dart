import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/notifications/index.dart';
import 'package:bontempo/models/notification_model.dart';
import 'package:bontempo/repositories/notification_repository.dart';

class NotificationBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationBloc() : super(UninitializedNotificationsState());

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    final currentState = state;
    NotificationRepository repository = NotificationRepository();

    if (event is LoadNotificationsEvent &&
        !_hasReachedMax(currentState) &&
        currentState is! LoadingNotificationsState) {
      try {
        if (currentState is UninitializedNotificationsState) {
          yield LoadingNotificationsState();
          Map<String, dynamic> data = await repository.getNotifications(
            page: 1,
          );

          yield LoadedNotificationsState(
            items: List<NotificationModel>.from(data['items']),
            hasReachedMax: data['data']['page'] >= data['data']['lastPage'],
            page: data['data']['page'],
          );
        } else {
          var state = currentState as LoadedNotificationsState;
          yield LoadingNotificationsState();
          Map<String, dynamic> data = await repository.getNotifications(
            page: state.page! + 1,
          );

          List<NotificationModel> items =
              List<NotificationModel>.from(data['items']);
          yield items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : LoadedNotificationsState(
                  items: items,
                  hasReachedMax:
                      data['data']['page'] >= data['data']['lastPage'],
                  page: data['data']['page'],
                );
        }
      } catch (error) {
        yield ErrorNotificationsState(error.toString());
      }
    }
  }

  bool _hasReachedMax(NotificationsState state) =>
      state is LoadedNotificationsState && state.hasReachedMax!;
}
