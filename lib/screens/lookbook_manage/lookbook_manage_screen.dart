import 'package:bontempo/blocs/clothing_select/index.dart';
import 'package:bontempo/blocs/look_manage/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/cards/look_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_clothes.dart';
import 'package:bontempo/components/forms/select_clothing_category.dart';
import 'package:bontempo/components/forms/select_clothing_color.dart';
import 'package:bontempo/components/layout/common_back_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/models/clothing_color_model.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LookBookManageScreen extends StatefulWidget {
  final LookModel? look;

  const LookBookManageScreen({Key? key, this.look}) : super(key: key);
  @override
  _LookBookManageScreenState createState() => _LookBookManageScreenState();
}

class _LookBookManageScreenState extends State<LookBookManageScreen> {
  bool _blockUI = false;
  int categoryId = 0;
  int colorId = 0;
  List<ClothingModel>? clothes = [];
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.look != null) {
      setState(() {
        clothes = widget.look!.clothing;
      });
      BlocProvider.of<ClothingSelectBloc>(context)
          .add(SetSelectClothingEvent(clothes!));
      _controller.value = TextEditingValue(text: widget.look!.title ?? '');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectCategory(ClothingCategoryModel category) {
    setState(() {
      this.categoryId = category.id;
    });
  }

  void selectColor(ClothingColorModel color) {
    setState(() {
      this.colorId = color.id;
    });
  }

  Future<void> saveLook() async {
    if (this._blockUI) return;
    if (_controller.text.isEmpty) {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: "Atenção!",
          description: "Você deve informar um título para o seu look.",
          buttonText: "Ok",
        ),
      );
    } else if (this.clothes!.isEmpty) {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: "Atenção!",
          description:
              "Você deve selecionar pelo menos uma peça para montar o seu look.",
          buttonText: "Ok",
        ),
      );
    } else {
      List<int> data =
          new List.from(this.clothes!.map((ClothingModel item) => item.id));
      if (widget.look != null) {
        BlocProvider.of<LookManageBloc>(context).add(EditLookEvent(
          widget.look!.id,
          {
            'clothing': data,
            'title': _controller.text,
          },
        ));
      } else {
        BlocProvider.of<LookManageBloc>(context).add(AddLookEvent({
          'clothing': data,
          'title': _controller.text,
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ClothingSelectBloc, ClothingSelectState>(
          listener: (BuildContext context, ClothingSelectState state) {
            if (state is SelectedClothingSelectState) {
              setState(() {
                this.clothes = state.items;
              });
            }
          },
        ),
        BlocListener<LookManageBloc, LookManageState>(
          listener: (context, state) {
            setState(() {
              _blockUI = state is SendingLookManageState;
            });
            if (state is ErrorLookManageState) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: "Algo deu errado",
                  description: state.errorMessage,
                  buttonText: "Fechar",
                ),
              );
            } else if (state is SentLookManageState) {}
          },
        ),
        BlocListener<LookManageBloc, LookManageState>(
          listener: (context, state) {
            setState(() {
              _blockUI = state is SendingLookManageState;
            });
            if (state is ErrorLookManageState) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: "Algo deu errado",
                  description: state.errorMessage,
                  buttonText: "Fechar",
                ),
              );
            } else if (state is SentLookManageState) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: "Look salvo!",
                  description:
                      'Seu look foi ${widget.look != null ? 'editado' : 'cadastrado'} com sucesso!',
                  buttonText: "Fechar",
                  callback: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyLooksViewRoute,
                      ModalRoute.withName(LookBookViewRoute),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CommonBackHeader(
              title: 'LookBook',
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(91),
                right: ScreenUtil().setWidth(91),
                bottom: ScreenUtil().setWidth(30),
              ),
              child: Text(
                'Selecione abaixo as peças para o seu Look.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: -0.1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30),
                bottom: ScreenUtil().setWidth(8),
              ),
              child: SizedBox(
                height: ScreenUtil().setWidth(50),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nome do look',
                    hintStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      color: black[200]!.withOpacity(.5),
                      fontStyle: FontStyle.italic,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: black[50]!),
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    errorBorder: errorColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: black[50]!),
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    contentPadding: new EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      bottom: ScreenUtil().setHeight(10),
                      left: ScreenUtil().setWidth(23),
                      right: ScreenUtil().setWidth(23),
                    ),
                  ),
                  style: TextStyle(
                    color: black,
                    fontSize: ScreenUtil().setSp(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
              ),
              child: SelectClothingCategory(
                onSelected: this.selectCategory,
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
            SelectClothes(
              bloc: BlocProvider.of<ClothingSelectBloc>(context),
              categoryId: this.categoryId,
              colorId: this.colorId,
              initialSelected: widget.look!.clothing!,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setWidth(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: black[50]!,
                  ),
                ),
                child: this.clothes != null && this.clothes!.isNotEmpty
                    ? LookCard(
                        look: new LookModel(
                          0,
                          '',
                          this.clothes!,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setWidth(230),
                        child: Center(
                          child: Text(
                            'Filtre e selecione acima as peças desejadas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black[50],
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30),
                bottom: ScreenUtil().setWidth(60),
              ),
              child: CommonButton(
                bordered: false,
                theme: CustomTheme.green,
                onTap: !this._blockUI && this.clothes!.isNotEmpty
                    ? this.saveLook
                    : null,
                child: !this._blockUI
                    ? Text(
                        'SALVAR LOOK',
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
            ),
          ],
        ),
      ),
    );
  }
}
