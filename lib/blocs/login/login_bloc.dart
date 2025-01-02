import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bontempo/blocs/authentication/index.dart';
import 'package:bontempo/blocs/login/index.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/models/user_model.dart';
import 'package:bontempo/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<DoLogin>(_onDoLogin);
    on<SocialLogin>(_onSocialLogin);
    on<RetrievePassword>(_onRetrievePassword);
    on<ToggleForm>(_onToggleForm);
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading('password'));
    try {
      UserModel user = await userRepository.authenticate(
        email: event.email,
        password: event.password,
      );
      getIt.get<AuthenticationBloc>().add(LoggedIn(user: user));
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(
          error: error is String ? error : 'Usuário ou senha inválidos.'));
    }
  }

  Future<void> _onSocialLogin(
      SocialLogin event, Emitter<LoginState> emit) async {
    UserModel? user;
    emit(LoginLoading(event.type));
    try {
      switch (event.type) {
        case 'google':
          user = await userRepository.googleAuthenticate();
          break;
        case 'facebook':
          user = await userRepository.facebookAuthenticate();
          break;
        case 'apple':
          user = await userRepository.appleAuthenticate();
          break;
        default:
          emit(LoginFailure(
            error: 'O método de login selecionado não existe.',
          ));
          return;
      }
      if (user != null) {
        getIt.get<AuthenticationBloc>().add(LoggedIn(user: user));
        emit(LoginSuccess());
      }
    } catch (error) {
      emit(LoginFailure(
          error: error is String ? error : 'Usuário ou senha inválidos.'));
    }
  }

  Future<void> _onRetrievePassword(
      RetrievePassword event, Emitter<LoginState> emit) async {
    emit(ForgotLoading());
    try {
      String response = await userRepository.retrievePassword(event.email);
      emit(ForgotSuccess(message: response));
    } catch (error) {
      emit(ForgotFailure(
          error: error is String ? error : 'Usuário ou senha inválidos.'));
    }
  }

  void _onToggleForm(ToggleForm event, Emitter<LoginState> emit) {
    emit(LoginFormState(forgotForm: event.forgotForm));
  }
}
