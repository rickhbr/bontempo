import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/blocs/clothing_select/index.dart';
import 'package:bontempo/components/dialogs/cloathing_confirm_dialog.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectClothes extends StatefulWidget {
  final int? categoryId;
  final int? colorId;
  final ClothingSelectBloc bloc;
  final List<ClothingModel>? initialSelected;

  const SelectClothes({
    Key? key,
    required this.bloc,
    this.categoryId,
    this.colorId,
    this.initialSelected,
  }) : super(key: key);

  @override
  _SelectClothesState createState() => _SelectClothesState();
}

class _SelectClothesState extends State<SelectClothes> {
  List<ClothingModel> _selected = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialSelected != null) {
      setState(() {
        _selected = widget.initialSelected!;
      });
    }
    BlocProvider.of<ClothingBloc>(context).add(LoadAllClothingEvent(
      categoryId: widget.categoryId,
      colorId: widget.colorId,
    ));
  }

  @override
  void didUpdateWidget(SelectClothes oldWidget) {
    if (widget.categoryId != oldWidget.categoryId ||
        widget.colorId != oldWidget.colorId) {
      BlocProvider.of<ClothingBloc>(context).add(LoadAllClothingEvent(
        categoryId: widget.categoryId,
        colorId: widget.colorId,
      ));
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget picture(ClothingModel item, int index) {
    return Container(
      width: ScreenUtil().setWidth(118),
      height: ScreenUtil().setWidth(118),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          padding: EdgeInsets.zero,
          minWidth: ScreenUtil().setWidth(118),
          height: ScreenUtil().setWidth(118),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_selected
                    .any((ClothingModel clothing) => clothing.id == item.id)) {
                  _selected.removeWhere(
                      (ClothingModel clothing) => item.id == clothing.id);
                  widget.bloc.add(UnselectClothingEvent(item));
                } else {
                  showScaleDialog(
                    context: context,
                    child: CloathingConfirmDialog(
                      item: item,
                      bloc: widget.bloc,
                    ),
                  );
                }
              });
            },
            child: AnimatedContainer(
              width: ScreenUtil().setWidth(118),
              height: ScreenUtil().setWidth(118),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? 5
                        : 1,
                    color: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? green
                        : black[50]!,
                  ),
                  bottom: BorderSide(
                    width: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? 5
                        : 1,
                    color: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? green
                        : black[50]!,
                  ),
                  left: BorderSide(
                    width: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? 5
                        : 1,
                    color: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? green
                        : (index > 0 ? Colors.white : black[50]!),
                  ),
                  right: BorderSide(
                    width: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? 5
                        : 1,
                    color: _selected.any(
                            (ClothingModel clothing) => clothing.id == item.id)
                        ? green
                        : black[50]!,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Image.network(
                    item.picture,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(118),
                    height: ScreenUtil().setWidth(118),
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            black,
                          ),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClothingSelectBloc, ClothingSelectState>(
      bloc: widget.bloc,
      listener: (BuildContext context, ClothingSelectState state) {
        if (state is SelectedClothingSelectState) {
          setState(() {
            _selected = state.items;
          });
        }
      },
      child: BlocBuilder<ClothingBloc, ClothingState>(
        builder: (BuildContext ctx, ClothingState state) {
          return Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(118),
            child: Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30),
                  ),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: (state is LoadedAllClothingState)
                      ? state.items!.length
                      : 4,
                  itemBuilder: (BuildContext context, int index) {
                    if (state is LoadedAllClothingState) {
                      ClothingModel item = state.items![index];
                      return picture(item, index);
                    } else {
                      return SizedBoxLoader(
                        width: ScreenUtil().setWidth(118),
                        height: ScreenUtil().setWidth(118),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
