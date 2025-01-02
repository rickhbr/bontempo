import 'package:bontempo/blocs/user/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/update_password/update_password_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatelessWidget {
  static const String routeName = "/update-password";

  @override
  Widget build(BuildContext context) {
    // Log the screen view
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdatePasswordPage',
      },
    );

    return Layout(
      showHeader: true,
      title: 'Alterar Senha',
      child: BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(),
        child: UpdatePasswordScreen(),
      ),
    );
  }
}
