import 'package:bontempo/components/forms/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/blocs/login/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/utils/dialogs.dart';

class FormForgot extends StatefulWidget {
  @override
  State<FormForgot> createState() => _FormForgotState();
}

class _FormForgotState extends State<FormForgot> {
  LoginBloc? loginBloc;
  bool _blockUI = false;

  void _submit(Map<String, dynamic> data) {
    if (!this._blockUI) {
      loginBloc!.add(RetrievePassword(
        email: data['email'],
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        setState(() {
          _blockUI = state is ForgotLoading;
        });
        if (state is ForgotFailure) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: "Falha no login",
              description: state.error,
              buttonText: "Fechar",
            ),
          );
        } else if (state is ForgotSuccess) {
          loginBloc!.add(ToggleForm(forgotForm: false));
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: "Solicitação enviada!",
              description: state.message,
              buttonText: "Fechar",
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
        ),
        color: black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(20),
                left: ScreenUtil().setWidth(55),
                right: ScreenUtil().setWidth(55),
              ),
              child: Text(
                'Digite seu e-mail abaixo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            CustomForm(
              theme: CustomTheme.white,
              buttonTheme: CustomTheme.transparent,
              fields: [
                {
                  'name': 'email',
                  'type': 'email',
                  'isRequired': true,
                  'labelText': 'E-mail',
                  'hintText': 'Digite o seu e-mail',
                },
              ],
              submitText: BlocBuilder<LoginBloc, LoginState>(
                builder: (BuildContext context, state) {
                  if (state is ForgotLoading) {
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
                      'RECUPERAR SENHA',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              onSubmit: this._submit,
              disabled: this._blockUI,
            ),
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(10),
              ),
              height: ScreenUtil().setWidth(50),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  height: ScreenUtil().setWidth(50),
                  child: TextButton(
                    onPressed: () {
                      loginBloc!.add(ToggleForm(forgotForm: false));
                    },
                    child: Text(
                      'Voltar para o login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w300,
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
