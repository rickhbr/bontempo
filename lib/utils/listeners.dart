import 'package:bontempo/blocs/gastronomy_types/index.dart';
import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/blocs/news_categories/index.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BlocListener<MovieGenresBloc, MovieGenresState> movieGenresListener(
    BuildContext context) {
  return BlocListener<MovieGenresBloc, MovieGenresState>(
    bloc: BlocProvider.of<MovieGenresBloc>(context),
    listener: (BuildContext context, MovieGenresState state) async {
      // Se já selecionou confere se já selecionou as categorias de notícias
      if (state is CheckedMovieGenresState && state.selected) {
        BlocProvider.of<NewsCategoriesBloc>(context)
            .add(CheckNewsCategoriesEvent());
        // Caso contrário, vai pra tela de seleção de gêneros
      } else if (state is CheckedMovieGenresState && !state.selected) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MovieGenresViewRoute,
          (Route<dynamic> route) => false,
        );
      }
    },
  );
}

BlocListener<NewsCategoriesBloc, NewsCategoriesState> newsCategoriesListener(
    BuildContext context) {
  return BlocListener<NewsCategoriesBloc, NewsCategoriesState>(
    bloc: BlocProvider.of<NewsCategoriesBloc>(context),
    listener: (BuildContext context, NewsCategoriesState state) async {
      // Se já selecionou confere se já selecionou os tipos gastronômicos
      if (state is CheckedNewsCategoriesState && state.selected) {
        BlocProvider.of<GastronomyTypesBloc>(context)
            .add(CheckGastronomyTypesEvent());
        // Caso contrário, vai pra tela de seleção de gêneros
      } else if (state is CheckedNewsCategoriesState && !state.selected) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          NewsCategoriesViewRoute,
          (Route<dynamic> route) => false,
        );
      }
    },
  );
}

BlocListener<GastronomyTypesBloc, GastronomyTypesState> gastronomyTypesListener(
    BuildContext context) {
  return BlocListener<GastronomyTypesBloc, GastronomyTypesState>(
    bloc: BlocProvider.of<GastronomyTypesBloc>(context),
    listener: (BuildContext context, GastronomyTypesState state) async {
      // Se já selecionou confere se já selecionou vai para a Home
      if (state is CheckedGastronomyTypesState && state.selected) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeViewRoute,
          (Route<dynamic> route) => false,
          arguments: HomeArguments(registerNotifications: true),
        );
        // Caso contrário vai pra tela de seleção de tipos
      } else if (state is CheckedGastronomyTypesState && !state.selected) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          GastronomyTypesViewRoute,
          (Route<dynamic> route) => false,
        );
      }
    },
  );
}
