import 'dart:developer';

import 'package:bontempo/components/cards/common_card.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:bontempo/screens/movie_details/movie_details_arguments.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/blocs/movies/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bontempo/theme/theme.dart';

class MovieCard extends StatefulWidget {
  final MovieModel movie;
  final bool? skip;

  const MovieCard({Key? key, required this.movie, this.skip}) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  MoviesBloc? _moviesBloc;
  MovieModel? movie;
  bool skip = false;

  @override
  void initState() {
    super.initState();
    _moviesBloc = BlocProvider.of<MoviesBloc>(context);
    movie = widget.movie;
    skip = widget.skip ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state is WatchedMovieState) {
          if (state.movie?.id == widget.movie.id) {
            setState(() {
              movie = state.movie;
            });
          }
        }
        if (state is NewMovieState) {
          setState(() {
            inspect(state.movie);
            movie = state.movie;
          });
        }
      },
      child: Column(
        children: <Widget>[
          CommonCard(
            buttonTitle: 'VER MAIS',
            secondButtonTitle: skip
                ? 'Pular'
                : (movie?.watched ?? false)
                    ? 'Assistido!'
                    : 'Já assisti',
            image: movie?.thumbnail ?? '',
            title: movie?.title ?? '',
            preTitle: 'Assista',
            icon: Icons.movie,
            secondButtonTheme: skip
                ? CustomTheme.black
                : (movie?.watched ?? false)
                    ? CustomTheme.grey
                    : CustomTheme.green,
            onTap: () {
              if (movie != null) {
                Navigator.pushNamed(
                  context,
                  MovieDetailsViewRoute,
                  arguments: MovieDetailsArguments(movie: movie!),
                );
              }
            },
            onTapSecond: () {
              if (skip) {
                _moviesBloc?.add(NextMovieEvent());
                return;
              }
              if (movie != null && !movie!.watched) {
                _moviesBloc?.add(MarkWatchedMoviesEvent(idMovie: movie!.id));
              }
            },
          ),
        ],
      ),
    );
  }
}
