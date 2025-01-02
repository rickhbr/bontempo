import 'package:bontempo/blocs/closet/closet_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/closet/closet_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClosetPage extends StatelessWidget {
  static const String routeName = "/closet";

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
      child: BlocProvider<ClosetBloc>(
        create: (BuildContext context) => new ClosetBloc(),
        child: ClosetScreen(),
      ),
    );
  }
}
