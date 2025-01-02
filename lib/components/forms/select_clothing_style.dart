import 'package:bontempo/blocs/clothing_styles/index.dart';
import 'package:bontempo/models/clothing_style_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectClothingStyle extends StatefulWidget {
  final Function onSelected;
  final bool allowClear;
  final int? initialSelected;

  const SelectClothingStyle({
    Key? key,
    required this.onSelected,
    this.allowClear = false,
    this.initialSelected,
  }) : super(key: key);

  @override
  _SelectClothingStyleState createState() => _SelectClothingStyleState();
}

class _SelectClothingStyleState extends State<SelectClothingStyle> {
  bool _loaded = false;
  String _selected = "Estilo";
  List<ClothingStyleModel> styles = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClothingStylesBloc>(context).add(LoadClothingStylesEvent());
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
              title: Text('Selecione o Estilo'),
              content: SingleChildScrollView(
                child: Column(
                  children: styles.map((item) {
                    return RadioListTile<ClothingStyleModel>(
                      title: Text(item.title),
                      value: item,
                      groupValue: styles.firstWhere(
                          (style) => style.title == _selected,
                          orElse: () => styles.first),
                      onChanged: (ClothingStyleModel? selected) {
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
    return BlocListener<ClothingStylesBloc, ClothingStylesState>(
      listener: (BuildContext ctx, ClothingStylesState state) {
        if (state is LoadedClothingStylesState) {
          if (widget.initialSelected != null) {
            setState(() {
              _selected = state.items
                  .firstWhere((ClothingStyleModel item) =>
                      widget.initialSelected == item.id)
                  .title;
            });
          }
          setState(() {
            styles = state.items;
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
