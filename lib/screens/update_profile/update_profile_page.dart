import 'package:bontempo/blocs/user/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/update_profile/update_profile_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfilePage extends StatelessWidget {
  static const String routeName = "/update-profile";

  @override
  Widget build(BuildContext context) {
    // Log the screen view
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );

    // Inicializar o ScreenUtil
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return Layout(
      showHeader: true,
      title: 'Meus Dados',
      child: BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(),
        child: UpdateProfileScreen(),
      ),
    );
  }
}
