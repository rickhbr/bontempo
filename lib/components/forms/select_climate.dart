import 'package:bontempo/blocs/climates/index.dart';
import 'package:bontempo/models/climate_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectClimate extends StatefulWidget {
  final Function onSelected;
  final bool allowClear;
  final bool multiple;
  final dynamic initialSelected;

  const SelectClimate({
    Key? key,
    required this.onSelected,
    this.allowClear = false,
    this.multiple = false,
    this.initialSelected,
  }) : super(key: key);

  @override
  _SelectClimateState createState() => _SelectClimateState();
}

class _SelectClimateState extends State<SelectClimate> {
  bool _loaded = false;
  String? _selected;
  List<ClimateModel> itemsSelected = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClimatesBloc>(context).add(LoadClimatesEvent());
  }

  bool itemSearchMatcher(String searchString, ClimateModel item) {
    return item.title.toLowerCase().contains(searchString.trim().toLowerCase());
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

  Future<void> _showSelectionDialog(
      BuildContext context, List<ClimateModel> items) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Selecione o Clima'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: items.map((item) {
                  return CheckboxListTile(
                    title: Text(item.title),
                    value: itemsSelected.contains(item),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          itemsSelected.add(item);
                        } else {
                          itemsSelected.remove(item);
                        }
                      });
                      widget.onSelected(itemsSelected);
                    },
                  );
                }).toList(),
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
    return BlocListener<ClimatesBloc, ClimatesState>(
      listener: (BuildContext ctx, ClimatesState state) {
        if (state is LoadedClimatesState) {
          if (widget.initialSelected != null) {
            if (widget.multiple) {
              setState(() {
                itemsSelected = state.items
                    .where((ClimateModel item) =>
                        widget.initialSelected.contains(item.id))
                    .toList();
              });
            } else {
              setState(() {
                _selected = state.items
                    .firstWhere((ClimateModel item) =>
                        widget.initialSelected == item.id)
                    .title;
              });
            }
          }
          setState(() {
            _loaded = true;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
        child: BlocBuilder<ClimatesBloc, ClimatesState>(
          builder: (BuildContext ctx, ClimatesState state) {
            if (state is LoadedClimatesState) {
              return GestureDetector(
                onTap: () {
                  _showSelectionDialog(context, state.items);
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.multiple
                                ? (itemsSelected.isNotEmpty
                                    ? itemsSelected
                                        .map((el) => el.title)
                                        .join(', ')
                                    : "Tipo de clima")
                                : (_selected ?? "Tipo de clima"),
                            style: TextStyle(
                              color: black[200],
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w400,
                              height: .9,
                            ),
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
              );
            } else {
              return Container(
                height: ScreenUtil().setWidth(50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: black[50]!,
                  ),
                ),
                child: Center(
                  child: loader(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
