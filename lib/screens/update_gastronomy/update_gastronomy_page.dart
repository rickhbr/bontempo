import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/update_gastronomy/update_gastronomy_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateGastronomyPage extends StatelessWidget {
  static const String routeName = "/update-gastronomy";

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
      showHeader: true,
      title: 'Culinária',
      child: BlocProvider<GastronomyTypesBloc>(
        create: (BuildContext context) => new GastronomyTypesBloc(),
        child: UpdateGastronomyScreen(),
      ),
    );
  }
}
