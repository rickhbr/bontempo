import 'package:bontempo/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationsState extends Equatable {
  NotificationsState getStateCopy();
  @override
  List<Object> get props => [];
}

class UninitializedNotificationsState extends NotificationsState {
  @override
  String toString() => 'UninitializedNotificationsState';

  @override
  NotificationsState getStateCopy() {
    return UninitializedNotificationsState();
  }
}

class LoadingNotificationsState extends NotificationsState {
  @override
  String toString() => 'LoadingNotificationsState';

  @override
  NotificationsState getStateCopy() {
    return LoadingNotificationsState();
  }
}

class LoadedNotificationsState extends NotificationsState {
  final List<NotificationModel>? items;
  final bool? hasReachedMax;
  final int? page;

  LoadedNotificationsState({this.items, this.hasReachedMax, this.page});

  LoadedNotificationsState copyWith({
    List<NotificationModel>? items,
    bool? hasReachedMax,
    int? page,
  }) {
    return LoadedNotificationsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() =>
      'LoadedNotificationsState { items: ${items!.length}, page: $page, hasReachedMax: $hasReachedMax }';

  @override
  NotificationsState getStateCopy() {
    return LoadedNotificationsState(
      items: this.items,
      hasReachedMax: this.hasReachedMax,
      page: this.page,
    );
  }
}

class ErrorNotificationsState extends NotificationsState {
  final String errorMessage;

  ErrorNotificationsState(this.errorMessage);

  @override
  String toString() => 'ErrorNotificationsState { ${this.errorMessage} }';

  @override
  NotificationsState getStateCopy() {
    return ErrorNotificationsState(this.errorMessage);
  }
}
