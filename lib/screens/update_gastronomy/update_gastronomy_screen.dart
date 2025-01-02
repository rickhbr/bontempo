import 'package:bontempo/blocs/gastronomy_types/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/toggle_with_image.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateGastronomyScreen extends StatefulWidget {
  const UpdateGastronomyScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateGastronomyScreenState createState() => _UpdateGastronomyScreenState();
}

class _UpdateGastronomyScreenState extends State<UpdateGastronomyScreen> {
  _UpdateGastronomyScreenState();

  List<GastronomyTypeModel>? gastronomyTypes;
  List<int> _selected = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GastronomyTypesBloc>(context)
        .add(LoadGastronomyTypesEvent());
  }

  void _save() {
    if (!this._blockUI) {
      if (this._selected.length < 1) {
        showScaleDialog(
          context: context,
          child: CustomDialog(
            title: 'Atenção!',
            description: 'Selecione no mínimo uma categoria de seu interesse.',
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
    } else {
      setState(() {
        this._selected.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener(
      bloc: BlocProvider.of<GastronomyTypesBloc>(context),
      listener: (BuildContext context, state) {
        if (state is LoadedGastronomyTypesState) {
          setState(() {
            gastronomyTypes = state.items;
          });
          BlocProvider.of<GastronomyTypesBloc>(context)
              .add(LoadClientGastronomyTypesEvent());
        }

        if (state is LoadedClientGastronomyTypesState) {
          state.items.forEach((GastronomyTypeModel item) {
            setState(() {
              this._selected.add(item.id);
            });
          });
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
            MyProfileViewRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: new ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50),
                    ),
                    child: Text(
                      "Qual sua culinária preferida?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              this.gastronomyTypes != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(40),
                      ),
                      width: double.infinity,
                      child: Wrap(
                        spacing: ScreenUtil().setWidth(10),
                        runSpacing: ScreenUtil().setHeight(14),
                        children: this
                            .gastronomyTypes!
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
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              CommonButton(
                theme: CustomTheme.black,
                onTap: this._selected.length > 0 && !this._blockUI
                    ? this._save
                    : null,
                child: BlocBuilder(
                  bloc: BlocProvider.of<GastronomyTypesBloc>(context),
                  builder: (BuildContext context, state) {
                    if (state is SavingGastronomyTypesState) {
                      return Material(
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
                      );
                    } else {
                      return Text(
                        'SALVAR',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
