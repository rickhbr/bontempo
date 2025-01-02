import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/models/movie_genre_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectMovieGenre extends StatefulWidget {
  final Function onSelected;

  const SelectMovieGenre({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectMovieGenreState createState() => _SelectMovieGenreState();
}

class _SelectMovieGenreState extends State<SelectMovieGenre> {
  bool _loaded = false;
  String _selected = "Selecione o Gênero";
  List<MovieGenreModel> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieGenresBloc>(context).add(LoadMovieGenresEvent());
  }

  Widget loader() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: ScreenUtil().setWidth(18),
        height: ScreenUtil().setWidth(18),
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation<Color>(
            black[200]!,
          ),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Selecione o Gênero'),
              content: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return RadioListTile<MovieGenreModel>(
                      title: Text(item.title),
                      value: item,
                      groupValue: items.firstWhere(
                          (genre) => genre.title == _selected,
                          orElse: () => items.first),
                      onChanged: (MovieGenreModel? selected) {
                        setState(() {
                          _selected = selected!.title;
                        });
                        widget.onSelected(selected);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieGenresBloc, MovieGenresState>(
      listener: (BuildContext ctx, MovieGenresState state) {
        if (state is LoadedMovieGenresState) {
          setState(() {
            items = state.items;
            _loaded = true;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
        child: GestureDetector(
          onTap: () {
            if (_loaded) {
              _showSelectionDialog(context);
            }
          },
          child: Container(
            height: ScreenUtil().setWidth(50),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: black[50]!,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: ButtonTheme(
                minWidth: double.infinity,
                height: ScreenUtil().setWidth(50),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _selected,
                        style: TextStyle(
                          color: black[200],
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (_loaded)
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: black[200],
                          size: ScreenUtil().setSp(18),
                        )
                      else
                        loader(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
