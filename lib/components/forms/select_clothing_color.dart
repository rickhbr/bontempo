import 'package:bontempo/blocs/clothing_colors/index.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectClothingColor extends StatefulWidget {
  final Function onSelected;
  final int? initialSelected;

  const SelectClothingColor(
      {Key? key, required this.onSelected, this.initialSelected})
      : super(key: key);

  @override
  _SelectClothingColorState createState() => _SelectClothingColorState();
}

class _SelectClothingColorState extends State<SelectClothingColor> {
  ClothingColorModel? _selected;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClothingColorsBloc>(context).add(LoadClothingColorsEvent());
  }

  Widget loader(ScreenUtil screen) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: screen.setWidth(18),
        height: screen.setWidth(18),
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: new AlwaysStoppedAnimation<Color>(
            black[200]!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClothingColorsBloc, ClothingColorsState>(
      listener: (BuildContext ctx, ClothingColorsState state) {
        if (state is LoadedClothingColorsState) {
          if (widget.initialSelected != null) {
            setState(() {
              _selected = state.items.firstWhere((ClothingColorModel item) =>
                  widget.initialSelected == item.id);
            });
          }
        }
      },
      child: BlocBuilder<ClothingColorsBloc, ClothingColorsState>(
        builder: (BuildContext ctx, ClothingColorsState state) {
          return Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(56),
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (state is LoadedClothingColorsState)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: state.items.map((ClothingColorModel item) {
                            return Container(
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setWidth(56),
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(5),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: ButtonTheme(
                                  padding: EdgeInsets.zero,
                                  minWidth: ScreenUtil().setWidth(40),
                                  height: ScreenUtil().setWidth(56),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selected = _selected != null &&
                                                _selected!.id == item.id
                                            ? null
                                            : item;
                                      });
                                      widget.onSelected(_selected);
                                    },
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 250),
                                      opacity: _selected != null &&
                                              item.id == _selected!.id
                                          ? 1
                                          : 0.2,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(40),
                                            height: ScreenUtil().setWidth(50),
                                            margin: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(6),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                              color: item.color,
                                            ),
                                          ),
                                          if (_selected != null &&
                                              item.id == _selected!.id)
                                            Positioned(
                                              top: ScreenUtil().setWidth(0),
                                              right: ScreenUtil().setWidth(-6),
                                              child: Container(
                                                width:
                                                    ScreenUtil().setWidth(14),
                                                height:
                                                    ScreenUtil().setWidth(14),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: ScreenUtil()
                                                        .setWidth(1),
                                                    color: Colors.grey[600]!,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.close,
                                                    size: ScreenUtil().setSp(7),
                                                    color: black[200],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
