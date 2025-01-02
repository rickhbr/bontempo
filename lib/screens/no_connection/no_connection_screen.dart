import 'dart:io';

import 'package:bontempo/components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/theme/theme.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  NoConnectionScreenState createState() {
    return new NoConnectionScreenState();
  }
}

class NoConnectionScreenState extends State<NoConnectionScreen> {
  bool _checking = false;

  void _checkConnection() async {
    if (_checking) return;
    setState(() {
      _checking = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      // Caso esteja conectado
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        UserRepository userRepository =
            RepositoryProvider.of<UserRepository>(context);
        String? token = await userRepository.getToken();

        Navigator.pushNamedAndRemoveUntil(
          context,
          token != null ? HomeViewRoute : LoginViewRoute,
          (Route<dynamic> route) => false,
        );
      } else {
        this._noConnection();
      }
    } catch (error) {
      this._noConnection();
    }
  }

  void _noConnection() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          'Não foi possível detectar nenhuma conexão com a internet.',
        ),
        action: SnackBarAction(
          label: 'FECHAR',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessenger.hideCurrentSnackBar();
            setState(() {
              _checking = false;
            });
          },
        ),
      ),
    );
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        _checking = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(378, 667),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              'Parece que você está sem conexão.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.white,
                height: .9,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(40),
            ),
            child: Icon(
              Icons.signal_wifi_off,
              size: ScreenUtil().setSp(100),
              color: Colors.white.withOpacity(.5),
            ),
          ),
          SizedBox(
            width: 180,
            child: CommonButton(
              onTap: this._checkConnection,
              child: Text(
                'TENTAR NOVAMENTE',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(11),
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
