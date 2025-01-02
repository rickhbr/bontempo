import 'package:bontempo/blocs/login/index.dart';
import 'package:bontempo/components/forms/form_forgot.dart';
import 'package:bontempo/components/forms/form_login.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showForgotForm = false;

  @override
  void initState() {
    UserRepository userRepository = new UserRepository();
    userRepository.requestFCMToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (context, currentState) {
        if (currentState is LoginFormState) {
          setState(() {
            _showForgotForm = currentState.forgotForm;
          });
        }
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: new ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(25),
                    bottom: ScreenUtil().setHeight(30),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                    color: white,
                    width: ScreenUtil().setWidth(280),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutExpo,
                  height: this._showForgotForm
                      ? ScreenUtil().setHeight(400)
                      : ScreenUtil().setHeight(740),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    switchInCurve: Curves.easeOutExpo,
                    switchOutCurve: Curves.easeInExpo,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            FadeTransition(
                      child: child,
                      opacity: animation,
                    ),
                    child: this._showForgotForm ? FormForgot() : FormLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
