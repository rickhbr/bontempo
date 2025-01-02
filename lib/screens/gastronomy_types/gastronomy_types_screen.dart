import 'package:bontempo/blocs/gastronomy_types/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/toggle_with_image.dart';
import 'package:bontempo/components/layout/layout_guest.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GastronomyTypesScreen extends StatefulWidget {
  const GastronomyTypesScreen({
    Key? key,
  }) : super(key: key);

  @override
  GastronomyTypesScreenState createState() {
    return new GastronomyTypesScreenState();
  }
}

class GastronomyTypesScreenState extends State<GastronomyTypesScreen> {
  GastronomyTypesScreenState();

  List<GastronomyTypeModel> gastronomyTypes = [];
  List<int> _selected = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GastronomyTypesBloc>(context)
        .add(LoadGastronomyTypesEvent());
    print('LoadGastronomyTypesEvent disparado');
  }

  void _save() {
    if (!this._blockUI) {
      if (this._selected.length < 1) {
        showScaleDialog(
          context: context,
          child: CustomDialog(
            title: 'Atenção!',
            description: 'Selecione no mínimo um gênero de seu interesse.',
            buttonText: "Fechar",
          ),
        );
      } else {
        setState(() {
          this._blockUI = true;
        });
        BlocProvider.of<GastronomyTypesBloc>(context)
            .add(SaveGastronomyTypesEvent(this._selected));
      }
    }
  }

  void _checkSelected(int id) {
    if (!this._selected.contains(id)) {
      setState(() {
        this._selected.add(id);
      });
      print('Selecionado: $id');
    } else {
      setState(() {
        this._selected.remove(id);
      });
      print('Removido: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return SafeArea(
      child: LayoutGuest(
        child: BlocListener<GastronomyTypesBloc, GastronomyTypesState>(
          listener: (BuildContext context, state) {
            if (state is LoadedGastronomyTypesState) {
              setState(() {
                gastronomyTypes = state.items;
              });
              print('Gastronomy types carregados: ${state.items}');
            }
            if (state is ErrorGastronomyTypesState) {
              setState(() {
                this._blockUI = false;
              });
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: 'Ocorreu um probleminha',
                  description: state.errorMessage,
                  buttonText: "Fechar",
                ),
              );
            }
            if (state is SavedGastronomyTypesState) {
              setState(() {
                this._blockUI = false;
              });
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeViewRoute,
                (Route<dynamic> route) => false,
                arguments: HomeArguments(registerNotifications: true),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(45),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(45),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/logo.svg',
                          color: white,
                          width: ScreenUtil().setWidth(280),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(50),
                        ),
                        child: Text(
                          "Qual sua culinária preferida?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 1.8,
                    ),
                    child: this.gastronomyTypes.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(40),
                            ),
                            width: double.infinity,
                            child: Wrap(
                              spacing: ScreenUtil().setWidth(10),
                              runSpacing: ScreenUtil().setHeight(14),
                              children: this
                                  .gastronomyTypes
                                  .map(
                                    (GastronomyTypeModel el) => ToggleWithImage(
                                      id: el.id,
                                      title: el.title,
                                      thumbnail: el.thumbnail!,
                                      lock: this._blockUI,
                                      callback: this._checkSelected,
                                      selected: this._selected.contains(el.id),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: ScreenUtil().setWidth(30),
                                height: ScreenUtil().setWidth(30),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(
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
          ),
        ),
        bottomBar: CommonButton(
          theme: CustomTheme.green,
          onTap:
              this._selected.isNotEmpty && !this._blockUI ? this._save : null,
          height: 50.0,
          child: BlocBuilder<GastronomyTypesBloc, GastronomyTypesState>(
            builder: (BuildContext context, state) {
              if (state is SavingGastronomyTypesState) {
                return Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: ScreenUtil().setWidth(30),
                    height: ScreenUtil().setWidth(30),
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return Text(
                  'PRÓXIMO',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
