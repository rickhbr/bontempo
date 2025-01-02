import 'package:bontempo/blocs/movies/index.dart';
import 'package:bontempo/components/cards/movie_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMovieCard extends StatelessWidget {
  final HomeModel home;

  const HomeMovieCard({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (home.movie != null)
          ColumnTitle(
            theme: home.mode == HomeMode.day
                ? CustomTheme.black
                : CustomTheme.white,
            lightTitle: 'Veja informações sobre os seus filmes favoritos!',
            boldTitle: 'Clique no link abaixo!',
          ),
        if (home.movie != null)
          BlocProvider(
            create: (BuildContext context) => MoviesBloc(),
            child: MovieCard(movie: home.movie!, skip: true),
          ),
        if (home.movie != null)
          GestureDetector(
              onTap: () => Navigator.pushNamed(
                    context,
                    MoviesViewRoute,
                  ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'VER TODOS',
                  style: TextStyle(
                    color:
                        home.mode == HomeMode.day ? Colors.black : Colors.white,
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w400,
                    letterSpacing: -.3,
                  ),
                ),
              )),
      ],
    );
  }
}
