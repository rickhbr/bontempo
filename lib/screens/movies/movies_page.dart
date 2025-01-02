import 'package:bontempo/blocs/movie_genres/movie_genres_bloc.dart';
import 'package:bontempo/blocs/movies/movies_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/movies/movies_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesPage extends StatelessWidget {
  static const String routeName = "/movies";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return Layout(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieGenresBloc>(
            create: (BuildContext context) => new MovieGenresBloc(),
          ),
          BlocProvider<MoviesBloc>(
            create: (BuildContext context) => new MoviesBloc(),
          ),
        ],
        child: MoviesScreen(),
      ),
    );
  }
}
