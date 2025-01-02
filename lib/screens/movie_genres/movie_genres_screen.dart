import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/blocs/news_categories/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/toggle_interest.dart';
import 'package:bontempo/components/layout/layout_guest.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:bontempo/utils/listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieGenresScreen extends StatefulWidget {
  const MovieGenresScreen({Key? key}) : super(key: key);

  @override
  MovieGenresScreenState createState() => MovieGenresScreenState();
}

class MovieGenresScreenState extends State<MovieGenresScreen> {
  MovieGenresScreenState();

  List<MovieGenreModel>? movieGenres;
  List<int> _selected = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    context.read<MovieGenresBloc>().add(LoadMovieGenresEvent());
  }

  void _save() {
    if (!this._blockUI) {
      if (this._selected.length < 1) {
        showScaleDialog(
          context: context,
          child: CustomDialog(
            title: 'Atenção!',
            description: 'Selecione no mínimo um gênero de seu interesse.',
            buttonText: "Fechar",
          ),
        );
      } else {
        setState(() {
          this._blockUI = true;
        });
        context
            .read<MovieGenresBloc>()
            .add(SaveMovieGenresEvent(this._selected));
      }
    }
  }

  void _checkSelected(int id) {
    if (!this._selected.contains(id)) {
      setState(() {
        this._selected.add(id);
      });
    } else {
      setState(() {
        this._selected.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return SafeArea(
      child: LayoutGuest(
        child: MultiBlocListener(
          listeners: [
            BlocListener<MovieGenresBloc, MovieGenresState>(
              listener: (context, state) {
                if (state is LoadedMovieGenresState) {
                  setState(() {
                    movieGenres = state.items;
                  });
                }
                if (state is ErrorMovieGenresState) {
                  setState(() {
                    this._blockUI = false;
                  });
                  showScaleDialog(
                    context: context,
                    child: CustomDialog(
                      title: 'Ocorreu um probleminha',
                      description: state.errorMessage,
                      buttonText: "Fechar",
                    ),
                  );
                }
                if (state is SavedMovieGenresState) {
                  setState(() {
                    this._blockUI = false;
                  });
                  context
                      .read<NewsCategoriesBloc>()
                      .add(CheckNewsCategoriesEvent());
                }
              },
            ),
            newsCategoriesListener(context),
            gastronomyTypesListener(context),
          ],
          child: Center(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(45),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(45),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/logo.svg',
                          color: white,
                          width: ScreenUtil().setWidth(280),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(50),
                        ),
                        child: Text(
                          "Escolha os gêneros de filmes de seu interesse.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 1.8,
                    ),
                    child: this.movieGenres != null
                        ? ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(30),
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: this.movieGenres!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ToggleInterest(
                                id: this.movieGenres![index].id,
                                title: this.movieGenres![index].title,
                                lock: this._blockUI,
                                callback: this._checkSelected,
                                selected: this
                                    ._selected
                                    .contains(this.movieGenres![index].id),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                color: black[300],
                                width: double.infinity,
                                height: 1,
                              );
                            },
                          )
                        : Center(
                            child: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: ScreenUtil().setWidth(30),
                                height: ScreenUtil().setWidth(30),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(
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
        bottomBar: CommonButton(
          theme: CustomTheme.green,
          onTap:
              this._selected.length > 0 && !this._blockUI ? this._save : null,
          height: 50.0,
          child: BlocBuilder<MovieGenresBloc, MovieGenresState>(
            builder: (BuildContext context, MovieGenresState state) {
              if (state is SavingMovieGenresState) {
                return Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: ScreenUtil().setWidth(30),
                    height: ScreenUtil().setWidth(30),
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return Text(
                  'PRÓXIMO',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
