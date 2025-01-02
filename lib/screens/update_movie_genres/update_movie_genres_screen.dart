import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/toggle_interest.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateMovieGenresScreen extends StatefulWidget {
  const UpdateMovieGenresScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateMovieGenresScreenState createState() =>
      _UpdateMovieGenresScreenState();
}

class _UpdateMovieGenresScreenState extends State<UpdateMovieGenresScreen> {
  _UpdateMovieGenresScreenState();

  List<MovieGenreModel>? movieGenres;
  List<int> _selected = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieGenresBloc>(context).add(LoadMovieGenresEvent());
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
        BlocProvider.of<MovieGenresBloc>(context)
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

    return BlocListener(
      bloc: BlocProvider.of<MovieGenresBloc>(context),
      listener: (BuildContext context, state) {
        if (state is LoadedMovieGenresState) {
          setState(() {
            movieGenres = state.items;
          });
          BlocProvider.of<MovieGenresBloc>(context)
              .add(LoadClientMovieGenresEvent());
        }

        if (state is LoadedClientMovieGenresState) {
          state.items.forEach((MovieGenreModel item) {
            setState(() {
              this._selected.add(item.id);
            });
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyProfileViewRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: new ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50),
                    ),
                    child: Text(
                      "Escolha os gêneros de filmes de seu interesse.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              this.movieGenres != null
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
                          titleColor: Colors.black,
                          callback: this._checkSelected,
                          selected: this
                              ._selected
                              .contains(this.movieGenres![index].id),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
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
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              CommonButton(
                theme: CustomTheme.black,
                onTap: this._selected.length > 0 && !this._blockUI
                    ? this._save
                    : null,
                child: BlocBuilder(
                  bloc: BlocProvider.of<MovieGenresBloc>(context),
                  builder: (BuildContext context, state) {
                    if (state is SavingMovieGenresState) {
                      return Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setWidth(30),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        'SALVAR',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
