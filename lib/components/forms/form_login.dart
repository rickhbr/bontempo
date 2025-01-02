import 'dart:io';

import 'package:bontempo/blocs/login/index.dart';
import 'package:bontempo/blocs/movie_genres/index.dart';
import 'package:bontempo/components/buttons/apple_auth_button.dart';
import 'package:bontempo/components/buttons/social_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/custom_form.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:bontempo/utils/listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLogin extends StatefulWidget {
  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  LoginBloc? loginBloc;
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  void _submit(Map<String, dynamic> data) {
    if (!_blockUI) {
      loginBloc!.add(DoLogin(
        email: data['email'],
        password: data['password'],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            setState(() {
              _blockUI = state is LoginLoading;
            });
            if (state is LoginFailure) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: "Falha no login",
                  description: state.error,
                  buttonText: "Fechar",
                ),
              );
            } else if (state is LoginSuccess) {
              BlocProvider.of<MovieGenresBloc>(context)
                  .add(CheckMovieGenresEvent());
            }
          },
        ),
        movieGenresListener(context),
        newsCategoriesListener(context),
        gastronomyTypesListener(context),
      ],
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
                bottom: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(55),
                right: ScreenUtil().setWidth(55),
              ),
              child: Text(
                'Entre com seu login e senha para acessar o App Bontempo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Center(
              child: CustomForm(
                theme: CustomTheme.white,
                buttonTheme: CustomTheme.transparent,
                fields: [
                  {
                    'name': 'email',
                    'type': 'email',
                    'isRequired': true,
                    'labelText': 'E-MAIL',
                    'hintText': 'Digite o seu e-mail',
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
                ],
                submitText: BlocBuilder<LoginBloc, LoginState>(
                  builder: (BuildContext context, state) {
                    if (state is LoginLoading && state.type == 'password') {
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
                        'ENTRAR',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                onSubmit: _submit,
                disabled: _blockUI,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(10),
              ),
              height: ScreenUtil().setWidth(35),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  height: ScreenUtil().setWidth(35),
                  child: TextButton(
                    onPressed: () {
                      loginBloc!.add(ToggleForm(forgotForm: true));
                    },
                    child: Text(
                      'Esqueci minha senha',
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(139),
                    height: 1,
                    color: black[200],
                  ),
                  Text(
                    'OU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(139),
                    height: 1,
                    color: black[200],
                  ),
                ],
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'Entre com seu Login Social / E-mail.',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: ScreenUtil().setSp(14),
            //         fontWeight: FontWeight.w300,
            //       ),
            //     ),
            //     SizedBox(
            //       height: ScreenUtil().setHeight(23),
            //     ),
            //     BlocBuilder<LoginBloc, LoginState>(
            //       builder: (BuildContext context, state) {
            //         return Column(
            //           children: <Widget>[
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: <Widget>[
            //                 SocialButton(
            //                   type: 'facebook',
            //                   loading: state is LoginLoading &&
            //                       state.type == 'facebook',
            //                   onTap: _blockUI
            //                       ? () {}
            //                       : () {
            //                           loginBloc!.add(
            //                             SocialLogin(type: 'facebook'),
            //                           );
            //                         },
            //                 ),
            //                 SizedBox(width: ScreenUtil().setWidth(29)),
            //                 SocialButton(
            //                   type: 'google',
            //                   loading: state is LoginLoading &&
            //                       state.type == 'google',
            //                   onTap: _blockUI
            //                       ? () {}
            //                       : () {
            //                           loginBloc!.add(
            //                             SocialLogin(type: 'google'),
            //                           );
            //                         },
            //                 ),
            //               ],
            //             ),
            //             if (Platform.isIOS)
            //               SizedBox(
            //                 height: ScreenUtil().setHeight(29),
            //               ),
            //             if (Platform.isIOS)
            //               AppleAuthButton(
            //                 loading:
            //                     state is LoginLoading && state.type == 'apple',
            //                 onTap: _blockUI
            //                     ? () {}
            //                     : () {
            //                         loginBloc!.add(
            //                           SocialLogin(type: 'apple'),
            //                         );
            //                       },
            //               ),
            //           ],
            //         );
            //       },
            //     ),
            //   ],
            // ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(35),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterViewRoute,
                      );
                    },
                    child: Text(
                      'Cadastrar com e-mail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.w700,
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
