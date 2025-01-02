import 'package:bontempo/blocs/stores/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/stores/stores_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresPage extends StatelessWidget {
  static const String routeName = "/stores-details";

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
      child: BlocProvider<StoreBloc>(
        create: (BuildContext context) => StoreBloc(),
        child: StoresScreen(),
      ),
    );
  }
}
