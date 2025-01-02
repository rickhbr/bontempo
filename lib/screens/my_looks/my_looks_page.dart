import 'package:bontempo/blocs/looks/looks_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/my_looks/my_looks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLooksPage extends StatelessWidget {
  static const String routeName = "/my-looks";

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
      child: BlocProvider<LooksBloc>(
        create: (BuildContext context) => new LooksBloc(),
        child: MyLooksScreen(),
      ),
    );
  }
}
