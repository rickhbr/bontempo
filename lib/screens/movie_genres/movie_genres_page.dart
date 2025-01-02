import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/blocs/movie_genres/movie_genres_bloc.dart';
import 'package:bontempo/blocs/news_categories/news_categories_bloc.dart';
import 'package:bontempo/screens/movie_genres/movie_genres_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieGenresPage extends StatelessWidget {
  static const String routeName = "/movie-genres";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return MultiBlocProvider(
      providers: [
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
      child: MovieGenresScreen(),
    );
  }
}
