import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/user/index.dart';
import 'package:bontempo/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UninitializedUserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UpdatePasswordEvent) {
      try {
        UserRepository repository = UserRepository();
        yield LoadingUpdatePasswordState();
        await repository.updatePassword(event.password!, event.repeatPassword!);
        yield LoadedUpdatePasswordState();
      } catch (error) {
        yield ErrorUpdatePasswordState(error.toString());
      }
    }

    if (event is UpdateProfileEvent) {
      try {
        UserRepository repository = UserRepository();
        yield LoadingUpdateProfileState();
        await repository.saveUser(event.data);
        yield LoadedUpdateProfileState();
      } catch (error) {
        yield ErrorUpdateProfileState(error.toString());
      }
    }
  }
}
