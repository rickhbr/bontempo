import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/avatar/index.dart';
import 'package:bontempo/repositories/user_repository.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc({AvatarState? initialState})
      : super(initialState ?? new UnitializedAvatarState());

  @override
  Stream<AvatarState> mapEventToState(
    AvatarEvent event,
  ) async* {
    if (event is UploadAvatarEvent) {
      try {
        UserRepository repository = new UserRepository();
        yield UploadingAvatarState();
        Map<String, dynamic> response =
            await repository.uploadAvatar(event.file);
        yield UploadedAvatarState(response);
      } catch (error) {
        yield ErrorAvatarState(error.toString());
      }
    }
  }
}
