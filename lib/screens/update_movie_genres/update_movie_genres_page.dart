import 'package:bontempo/blocs/movie_genres/movie_genres_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/update_movie_genres/update_movie_genres_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMovieGenresPage extends StatelessWidget {
  static const String routeName = "/update-movie-genres";

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
      showHeader: true,
      title: 'Filmes',
      child: BlocProvider<MovieGenresBloc>(
        create: (BuildContext context) => new MovieGenresBloc(),
        child: UpdateMovieGenresScreen(),
      ),
    );
  }
}
