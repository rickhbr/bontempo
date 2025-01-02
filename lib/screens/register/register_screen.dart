import 'package:bontempo/components/forms/form_register.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    UserRepository userRepository = new UserRepository();
    userRepository.initializeGeolocation();
    userRepository.requestFCMToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: new ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(54),
                  bottom: ScreenUtil().setHeight(30),
                ),
                child: SvgPicture.asset(
                  'assets/svg/logo.svg',
                  color: white,
                  width: ScreenUtil().setWidth(280),
                ),
              ),
              FormRegister(),
              Container(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  top: ScreenUtil().setHeight(23),
                  bottom: ScreenUtil().setHeight(20),
                ),
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: ScreenUtil().setWidth(50),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginViewRoute,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Voltar para o login',
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
      ),
    );
  }
}
