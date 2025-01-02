import 'package:bontempo/blocs/register/register_bloc.dart';
import 'package:bontempo/components/layout/layout_guest.dart';
import 'package:bontempo/screens/register/register_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return LayoutGuest(
      child: BlocProvider<RegisterBloc>(
        create: (BuildContext context) => new RegisterBloc(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: RegisterScreen(),
        ),
      ),
    );
  }
}
