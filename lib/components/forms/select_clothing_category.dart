import 'package:bontempo/blocs/clothing_categories/index.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectClothingCategory extends StatefulWidget {
  final Function onSelected;
  final bool allowClear;
  final int? initialSelected;

  const SelectClothingCategory({
    Key? key,
    required this.onSelected,
    this.allowClear = false,
    this.initialSelected,
  }) : super(key: key);

  @override
  _SelectClothingCategoryState createState() => _SelectClothingCategoryState();
}

class _SelectClothingCategoryState extends State<SelectClothingCategory> {
  bool _loaded = false;
  String _selected = "Categoria";
  List<ClothingCategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClothingCategoriesBloc>(context)
        .add(LoadClothingCategoriesEvent());
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
              title: Text('Selecione a Categoria'),
              content: SingleChildScrollView(
                child: Column(
                  children: categories.map((item) {
                    return RadioListTile<ClothingCategoryModel>(
                      title: Text(item.title),
                      value: item,
                      groupValue: categories.firstWhere(
                          (category) => category.title == _selected,
                          orElse: () => categories.first),
                      onChanged: (ClothingCategoryModel? selected) {
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
    return BlocListener<ClothingCategoriesBloc, ClothingCategoriesState>(
      listener: (BuildContext ctx, ClothingCategoriesState state) {
        print('Current state: $state');
        if (state is LoadedClothingCategoriesState) {
          if (widget.initialSelected != null) {
            setState(() {
              _selected = state.items
                  .firstWhere((ClothingCategoryModel item) =>
                      widget.initialSelected == item.id)
                  .title;
            });
          }
          setState(() {
            categories = state.items;
            _loaded = true;
          });
        } else if (state is ErrorClothingCategoriesState) {
          print('Error state: ${state.errorMessage}');
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
