import 'package:bontempo/components/forms/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/blocs/register/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/utils/dialogs.dart';

class FormRegister extends StatefulWidget {
  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  late RegisterBloc registerBloc;
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  void _submit(Map<String, dynamic> data) {
    if (!this._blockUI) {
      registerBloc.add(RegisterUser(data: data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        setState(() {
          _blockUI = state is RegisterLoading;
        });
        if (state is RegisterFailure) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: "Ocorreu um erro",
              description: state.error,
              buttonText: "Fechar",
            ),
          );
        } else if (state is RegisterSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MovieGenresViewRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(30),
                left: ScreenUtil().setWidth(36),
                right: ScreenUtil().setWidth(36),
              ),
              child: Text(
                'Preencha os campos abaixo para cadastrar-se e acessar o App Bontempo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.14,
                ),
              ),
            ),
            CustomForm(
              theme: CustomTheme.white,
              buttonTheme: CustomTheme.transparent,
              fields: [
                {
                  'capitalize': true,
                  'name': 'name',
                  'type': 'text',
                  'isRequired': true,
                  'labelText': 'NOME',
                  'hintText': 'Digite o seu nome',
                },
                {
                  'name': 'email',
                  'type': 'email',
                  'isRequired': true,
                  'labelText': 'E-MAIL',
                  'hintText': 'Digite o seu e-mail',
                },
                {
                  'name': 'phone',
                  'type': 'phone',
                  'isRequired': true,
                  'labelText': 'TELEFONE',
                  'hintText': 'Digite o seu telefone',
                },
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
                {
                  'name': 'has_furniture',
                  'type': 'checkbox',
                  'labelText': 'Eu tenho móveis Bontempo',
                },
              ],
              submitText: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (BuildContext context, state) {
                  if (state is RegisterLoading) {
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
                      'CADASTRAR',
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
          ],
        ),
      ),
    );
  }
}
