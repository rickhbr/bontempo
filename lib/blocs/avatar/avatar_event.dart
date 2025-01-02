import 'package:equatable/equatable.dart';

abstract class AvatarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadAvatarEvent extends AvatarEvent {
  final String file;

  UploadAvatarEvent(this.file);

  @override
  String toString() => 'UploadAvatarEvent';
}
