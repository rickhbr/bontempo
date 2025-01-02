import 'package:bontempo/blocs/home_look/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/cards/look_card.dart';
import 'package:bontempo/components/typography/row_title.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeLookCard extends StatefulWidget {
  final HomeModel home;
  final bool isSuggestion;

  const HomeLookCard({Key? key, required this.home, this.isSuggestion = false})
      : super(key: key);

  @override
  _HomeLookCardState createState() => _HomeLookCardState();
}

class _HomeLookCardState extends State<HomeLookCard> {
  HomeLookBloc? _homeLookBloc;
  List<ClothingModel>? clothing;
  bool savedLook = false;

  @override
  void initState() {
    super.initState();
    this._homeLookBloc = BlocProvider.of<HomeLookBloc>(context);
    setState(() {
      this.clothing =
          widget.isSuggestion ? widget.home.clothing : widget.home.scheduled;
    });
  }

  void skipLook() {
    _homeLookBloc!.add(SkipHomeLookEvent());
  }

  void saveLook() {
    _homeLookBloc!.add(SaveHomeLookEvent({
      'clothing': this.clothing!.map((ClothingModel item) => item.id).toList(),
    }));
  }

  @override
  Widget build(BuildContext context) {
    String lightTitleText = widget.isSuggestion ? 'Look do' : 'Look agendado';
    String boldTitleText = widget.isSuggestion ? 'dia!' : 'para hoje';

    return BlocListener<HomeLookBloc, HomeLookState>(
      listener: (context, state) {
        if (state is NewHomeLookState) {
          if (state.clothing != null) {
            setState(() {
              this.clothing = state.clothing;
              this.savedLook = false;
            });
          } else {
            showSnackbar(
              context: context,
              text: 'Nenhuma sugestão encontrada no momento.',
            );
          }
        }
        if (state is SavedHomeLookState) {
          setState(() {
            this.savedLook = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Look salvo com sucesso!"),
              action: SnackBarAction(
                label: 'FECHAR',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      child: Column(
        children: <Widget>[
          RowTitle(
            lightTitle: lightTitleText,
            boldTitle: boldTitleText,
            theme: widget.home.mode == HomeMode.day
                ? CustomTheme.black
                : CustomTheme.white,
          ),
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(25),
                ),
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(60),
                child: LookCard(
                  paddingBottom: 50.0,
                  look: new LookModel(
                    0,
                    '',
                    this.clothing,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (widget.isSuggestion)
                      SizedBox(
                        width: (MediaQuery.of(context).size.width -
                                ScreenUtil().setWidth(70)) /
                            2,
                        child: CommonButton(
                          height: ScreenUtil().setWidth(50),
                          bordered: false,
                          alwaysFilled: true,
                          theme: CustomTheme.green,
                          onTap: !this.savedLook ? this.saveLook : null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/heart.svg',
                                color: Colors.white,
                                height: ScreenUtil().setWidth(15),
                                width: ScreenUtil().setWidth(15),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(12),
                              ),
                              Text(
                                !this.savedLook ? 'SALVAR LOOK' : 'LOOK SALVO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.isSuggestion)
                      SizedBox(
                        width: (MediaQuery.of(context).size.width -
                                ScreenUtil().setWidth(70)) /
                            2,
                        child: CommonButton(
                          height: ScreenUtil().setWidth(50),
                          bordered: false,
                          theme: CustomTheme.black,
                          onTap: this.skipLook,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/close.svg',
                                color: Colors.white,
                                height: ScreenUtil().setWidth(15),
                                width: ScreenUtil().setWidth(15),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(12),
                              ),
                              Text(
                                'PULAR LOOK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
