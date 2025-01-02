import 'package:bontempo/blocs/user/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/custom_form.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _submit(Map<String, dynamic> data) {
    if (!this._loading) {
      BlocProvider.of<UserBloc>(context).add(
        UpdatePasswordEvent(
          password: data['password'],
          repeatPassword: data['password_confirm'],
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

    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext ctx, UserState state) {
        if (state is ErrorUpdatePasswordState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedUpdatePasswordState) {
          setState(() {
            _loading = false;
          });
          Navigator.pop(context);
        }
        if (state is LoadingUpdatePasswordState) {
          setState(() {
            _loading = true;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      ScreenUtil().setWidth(70) -
                      ScreenUtil().setHeight(98),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(30),
                        left: ScreenUtil().setWidth(36),
                        right: ScreenUtil().setWidth(36),
                      ),
                      child: Text(
                        'Digite sua nova senha nos campos abaixo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w300,
                          letterSpacing: -.14,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(36),
                        left: ScreenUtil().setWidth(36),
                        right: ScreenUtil().setWidth(36),
                      ),
                      child: CustomForm(
                        theme: CustomTheme.green,
                        buttonTheme: CustomTheme.black,
                        fields: [
                          {
                            'name': 'password',
                            'type': 'password',
                            'isRequired': true,
                            'minLength': 6,
                            'labelText': 'SENHA',
                            'showPassword': true,
                            'hintText': 'Digite senha',
                          },
                          {
                            'name': 'password_confirm',
                            'type': 'password',
                            'isRequired': true,
                            'equalTo': 'password',
                            'minLength': 6,
                            'labelText': 'REPETIR SENHA',
                            'showPassword': true,
                            'hintText': 'Repita a sua senha',
                          },
                        ],
                        submitText: BlocBuilder(
                          bloc: BlocProvider.of<UserBloc>(context),
                          builder: (BuildContext context, state) {
                            if (state is LoadingUpdatePasswordState) {
                              return Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setWidth(30),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
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
                        onSubmit: this._submit,
                        disabled: this._loading,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
