import 'dart:async';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/blocs/register/index.dart';
import 'package:bontempo/blocs/authentication/index.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    UserRepository userRepository = UserRepository();

    emit(RegisterLoading());
    try {
      UserModel user = await userRepository.registerUser(event.data);
      getIt.get<AuthenticationBloc>().add(LoggedIn(user: user));
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
