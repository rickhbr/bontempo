import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bontempo/blocs/clothing_add/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_climate.dart';
import 'package:bontempo/components/forms/select_clothing_category.dart';
import 'package:bontempo/components/forms/select_clothing_color.dart';
import 'package:bontempo/components/forms/select_clothing_style.dart';
import 'package:bontempo/components/layout/common_back_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/climate_model.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/models/clothing_style_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ClothesConfigScreen extends StatefulWidget {
  final List<dynamic>? images;

  const ClothesConfigScreen({Key? key, this.images}) : super(key: key);
  @override
  _ClothesConfigScreenState createState() => _ClothesConfigScreenState();
}

class _ClothesConfigScreenState extends State<ClothesConfigScreen> {
  final PageController _pageViewController = PageController();

  int? currentPage = 0;
  int? categoryId = 0;
  int? styleId = 0;
  int? colorId = 0;
  List<int>? climateId = [];
  int? appreciation = 0;
  bool? _blockUI = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void selectCategory(ClothingCategoryModel category) {
    this.categoryId = category.id;
  }

  void selectClimate(List<ClimateModel> climates) {
    this.climateId = climates.map((e) => e.id).toList();
  }

  void selectColor(ClothingColorModel color) {
    this.colorId = color.id;
  }

  void selectStyle(ClothingStyleModel style) {
    this.styleId = style.id;
  }

  void selectAppeciation(int appreciation) {
    setState(() {
      this.appreciation = appreciation;
    });
  }

  Future<void> saveClothing() async {
    if (this._blockUI!) return;

    if (this.categoryId != null &&
        this.climateId != null &&
        this.colorId != null &&
        this.styleId != null &&
        this.appreciation != null) {
      String? file;
      dynamic image = widget.images![this.currentPage!];
      if (image is File) {
        List<int> imageBytes = await image.readAsBytes();
        file = base64.encode(imageBytes);
      } else if (image is AssetEntity) {
        Uint8List? fileBytes = await image.originBytes;
        if (fileBytes != null) {
          file = base64.encode(fileBytes);
        } else {
          throw Exception("Failed to get image bytes");
        }
      }

      BlocProvider.of<ClothingAddBloc>(context).add(AddClothingEvent({
        'file': 'data:image/jpeg;base64,$file',
        'category_id': this.categoryId,
        'color_id': this.colorId,
        'style_id': this.styleId,
        'appreciation': this.appreciation,
        'climates': this.climateId
      }));
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

    return BlocListener<ClothingAddBloc, ClothingAddState>(
      listener: (context, state) {
        setState(() {
          _blockUI = state is SendingClothingAddState;
        });
        if (state is ErrorClothingAddState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: "Algo deu errado",
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        } else if (state is SentClothingAddState) {
          this.categoryId = null;
          this.climateId = null;
          this.colorId = null;
          this.styleId = null;
          this.appreciation = null;
          this._pageViewController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
        }
      },
      child: PageView(
        onPageChanged: (int index) {
          currentPage = index;
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageViewController,
        children: [
          ...List.generate(
            widget.images!.length,
            (index) {
              return SingleChildScrollView(
                key: Key('item-${index.toString()}'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CommonBackHeader(
                      title:
                          '${(index + 1).toString()}/${widget.images!.length.toString()}',
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
                            child: (widget.images![index] is AssetEntity)
                                ? AssetEntityImage(
                                    widget.images![index],
                                    height: ScreenUtil().setWidth(196),
                                    width: ScreenUtil().setWidth(196),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext ctx,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: SizedBox(
                                          width: ScreenUtil().setWidth(18),
                                          height: ScreenUtil().setWidth(18),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              black[200]!,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    widget.images![index],
                                    fit: BoxFit.contain,
                                    height: ScreenUtil().setWidth(196),
                                    width: ScreenUtil().setWidth(196),
                                  ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(19),
                          ),
                          SelectClothingCategory(
                            onSelected: this.selectCategory,
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
                                  multiple: true,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              Expanded(
                                child: SelectClothingStyle(
                                  onSelected: this.selectStyle,
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
                                            onPressed: () {
                                              this.selectAppeciation(number);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.zero,
                                              height: ScreenUtil().setWidth(70),
                                              width: ScreenUtil().setWidth(70),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  'assets/svg/smile-$number.svg',
                                                  color: number ==
                                                          this.appreciation
                                                      ? green
                                                      : black[200]!,
                                                  height:
                                                      ScreenUtil().setWidth(38),
                                                  width:
                                                      ScreenUtil().setWidth(38),
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
                            onTap: !this._blockUI! ? this.saveClothing : null,
                            child: !this._blockUI!
                                ? Text(
                                    'CADASTRAR',
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.images!.length > 1
                              ? 'Suas peças foram cadastradas com sucesso!'
                              : 'Sua peça foi cadastrada com sucesso!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(34),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(36),
                            left: ScreenUtil().setWidth(42),
                            right: ScreenUtil().setWidth(42),
                          ),
                          child: Text(
                            widget.images!.length > 1
                                ? 'Você cadastrou as peças e agora você pode montar um look com elas :)'
                                : 'Você cadastrou a peça e agora você pode montar um look com ela :)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    CommonButton(
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil().setWidth(8),
                      ),
                      bordered: false,
                      theme: CustomTheme.green,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LookBookAddViewRoute,
                          ModalRoute.withName(LookBookViewRoute),
                        );
                      },
                      child: Text(
                        'MONTAR LOOKBOOK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CommonButton(
                      bordered: false,
                      theme: CustomTheme.black,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ClothesAddViewRoute,
                          ModalRoute.withName(LookBookViewRoute),
                        );
                      },
                      child: Text(
                        'CADASTRAR MAIS PEÇAS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
