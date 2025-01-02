import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/blocs/login/login_bloc.dart';
import 'package:bontempo/blocs/movie_genres/movie_genres_bloc.dart';
import 'package:bontempo/blocs/news_categories/news_categories_bloc.dart';
import 'package:bontempo/components/layout/layout_guest.dart';
import 'package:bontempo/screens/login/login_screen.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return LayoutGuest(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider<MovieGenresBloc>(
            create: (BuildContext context) => MovieGenresBloc(),
          ),
          BlocProvider<NewsCategoriesBloc>(
            create: (BuildContext context) => NewsCategoriesBloc(),
          ),
          BlocProvider<GastronomyTypesBloc>(
            create: (BuildContext context) => GastronomyTypesBloc(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: LoginScreen(),
        ),
      ),
    );
  }
}
