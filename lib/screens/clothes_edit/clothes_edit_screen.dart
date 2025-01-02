import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_climate.dart';
import 'package:bontempo/components/forms/select_clothing_category.dart';
import 'package:bontempo/components/forms/select_clothing_color.dart';
import 'package:bontempo/components/forms/select_clothing_style.dart';
import 'package:bontempo/components/layout/common_back_header.dart';
import 'package:bontempo/models/climate_model.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/clothing_style_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClothesEditScreen extends StatefulWidget {
  final ClothingModel? clothing;
  final ClothingBloc? clothingBloc;

  const ClothesEditScreen({
    Key? key,
    this.clothing,
    this.clothingBloc,
  }) : super(key: key);

  @override
  _ClothesEditScreenState createState() => _ClothesEditScreenState();
}

class _ClothesEditScreenState extends State<ClothesEditScreen> {
  int appreciation = 0;
  int categoryId = 0;
  int styleId = 0;
  int colorId = 0;
  List<int> climateId = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      appreciation = widget.clothing!.appreciation;
      categoryId = widget.clothing!.idCategory;
      styleId = widget.clothing!.idStyle;
      colorId = widget.clothing!.idColor;
      climateId = widget.clothing!.idClimates;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectCategory(ClothingCategoryModel? category) {
    this.categoryId = category!.id;
  }

  void selectClimate(List<ClimateModel>? climates) {
    this.climateId = climates!.map((e) => e.id).toList();
  }

  void selectColor(ClothingColorModel? color) {
    this.colorId = color!.id;
  }

  void selectStyle(ClothingStyleModel? style) {
    this.styleId = style!.id;
  }

  void selectAppeciation(int appreciation) {
    setState(() {
      this.appreciation = appreciation;
    });
  }

  Future<void> saveClothing() async {
    if (this._blockUI) return;

    if (this.categoryId != 0 &&
        this.climateId.isNotEmpty &&
        this.colorId != 0 &&
        this.styleId != 0 &&
        this.appreciation != 0) {
      widget.clothingBloc!.add(EditClothingEvent(
        idClothing: widget.clothing!.id,
        data: {
          'category_id': this.categoryId,
          'color_id': this.colorId,
          'style_id': this.styleId,
          'appreciation': this.appreciation,
          'climates': this.climateId
        },
      ));
    } else {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: "Atenção!",
          description: "Selecione todas as opções desta peça.",
          buttonText: "Ok",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ClothingBloc, ClothingState>(
      bloc: widget.clothingBloc!,
      listener: (context, state) {
        setState(() {
          _blockUI = state is EditingClothingState;
        });
        if (state is EditedClothingState) {
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CommonBackHeader(
              title: 'Editar peça',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setWidth(196),
                    width: ScreenUtil().setWidth(196),
                    child: Hero(
                      tag: 'image${widget.clothing!.id.toString()}',
                      child: Image.network(
                        widget.clothing!.picture,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        height: ScreenUtil().setWidth(196),
                        width: ScreenUtil().setWidth(196),
                        loadingBuilder: (BuildContext ctx, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              height: ScreenUtil().setWidth(28),
                              width: ScreenUtil().setWidth(28),
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  black,
                                ),
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(19),
                  ),
                  SelectClothingCategory(
                    onSelected: this.selectCategory,
                    initialSelected: widget.clothing!.idCategory,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(25),
              ),
              child: SelectClothingColor(
                onSelected: this.selectColor,
                initialSelected: widget.clothing!.idColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30),
                bottom: ScreenUtil().setWidth(60),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SelectClimate(
                          onSelected: this.selectClimate,
                          initialSelected: widget.clothing!.idClimates,
                          multiple: true,
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Expanded(
                        child: SelectClothingStyle(
                          onSelected: this.selectStyle,
                          initialSelected: widget.clothing!.idStyle,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setWidth(25),
                    ),
                    child: Text(
                      'O quanto você gosta desta peça?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black[200],
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [1, 2, 3]
                        .map((int number) => Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(6),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: ButtonTheme(
                                  minWidth: ScreenUtil().setWidth(70),
                                  height: ScreenUtil().setWidth(70),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      this.selectAppeciation(number);
                                    },
                                    child: Container(
                                      height: ScreenUtil().setWidth(70),
                                      width: ScreenUtil().setWidth(70),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/svg/smile-$number.svg',
                                          color: number == this.appreciation
                                              ? green
                                              : black[200]!,
                                          height: ScreenUtil().setWidth(38),
                                          width: ScreenUtil().setWidth(38),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  CommonButton(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                    ),
                    bordered: false,
                    theme: CustomTheme.green,
                    onTap: !this._blockUI ? this.saveClothing : null,
                    child: !this._blockUI
                        ? Text(
                            'SALVAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Material(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
