import 'package:bontempo/blocs/authentication/index.dart';
import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/utils/listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bontempo/theme/theme.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) async {
            // Caso esteja autenticado, confere se já selecionou ou gêneros:
            if (state is AuthenticationAuthenticated) {
              BlocProvider.of<MovieGenresBloc>(context)
                  .add(CheckMovieGenresEvent());
              // Caso contrário, vai para o login
            } else if (state is AuthenticationUnauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginViewRoute,
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
        movieGenresListener(context),
        newsCategoriesListener(context),
        gastronomyTypesListener(context),
      ],
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: black,
          child: SafeArea(
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
