import 'package:bontempo/blocs/movies/index.dart';
import 'package:bontempo/components/cards/movie_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_movie_genre.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/common_card_loader.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<MovieModel> _movies = [];
  bool _loading = false;
  int _idGenre = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<MoviesBloc>(context).add(LoadMoviesEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
      BlocProvider.of<MoviesBloc>(context)
          .add(LoadMoviesEvent(idGenre: _idGenre));
    }
  }

  void changeGenre(MovieGenreModel genre) {
    setState(() {
      _idGenre = genre.id;
    });
    BlocProvider.of<MoviesBloc>(context).add(ResetMoviesEvent());
    BlocProvider.of<MoviesBloc>(context)
        .add(LoadMoviesEvent(idGenre: genre.id));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<MoviesBloc, MoviesState>(
      listener: (BuildContext ctx, MoviesState state) {
        if (state is ErrorMoviesState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedMoviesState) {
          setState(() {
            _movies.addAll(state.items!);
            _loading = false;
          });
        }
        if (state is UninitializedMoviesState) {
          setState(() {
            _movies.clear();
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Dicas de Filmes',
                description: 'Veja informações sobre os seus filmes favoritos',
                descriptionPadding: 66.0,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      ScreenUtil().setWidth(150) -
                      ScreenUtil().setHeight(84),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    right: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setHeight(36),
                    top: ScreenUtil().setWidth(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SelectMovieGenre(
                        onSelected: this.changeGenre,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _movies.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return BlocProvider(
                            create: (BuildContext context) => MoviesBloc(),
                            child: MovieCard(movie: _movies[index]),
                          );
                        },
                      ),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (BuildContext ctx, MoviesState state) {
                          if (state is LoadingMoviesState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _movies.length > 0 ? 1 : 3,
                                CommonCardLoader(),
                              ).toList(),
                            );
                          }
                          if (state is LoadedMoviesState &&
                              _movies.length == 0) {
                            return NoResults();
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
