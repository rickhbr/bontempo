import 'package:bontempo/blocs/gastronomy_types/index.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGastronomyType extends StatefulWidget {
  final Function onSelected;

  const SelectGastronomyType({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectGastronomyTypeState createState() => _SelectGastronomyTypeState();
}

class _SelectGastronomyTypeState extends State<SelectGastronomyType> {
  bool _loaded = false;
  String _selected = "Selecione o tipo de culinária";
  List<GastronomyTypeModel> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GastronomyTypesBloc>(context)
        .add(LoadGastronomyTypesEvent());
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
              title: Text('Selecione o tipo de culinária'),
              content: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return RadioListTile<GastronomyTypeModel>(
                      title: Text(item.title),
                      value: item,
                      groupValue: items.firstWhere(
                          (type) => type.title == _selected,
                          orElse: () => items.first),
                      onChanged: (GastronomyTypeModel? selected) {
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
    return BlocListener<GastronomyTypesBloc, GastronomyTypesState>(
      listener: (BuildContext ctx, GastronomyTypesState state) {
        if (state is LoadedGastronomyTypesState) {
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
