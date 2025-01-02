import 'package:bontempo/blocs/avatar/avatar_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/my_profile/my_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatelessWidget {
  static const String routeName = "/my-profiles";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );

    return Layout(
      child: BlocProvider<AvatarBloc>(
        create: (BuildContext context) => new AvatarBloc(),
        child: MyProfileScreen(),
      ),
    );
  }
}
