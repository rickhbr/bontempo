import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/screens/gastronomy_types/gastronomy_types_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GastronomyTypesPage extends StatelessWidget {
  static const String routeName = "/gastronomy-types";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return BlocProvider<GastronomyTypesBloc>(
      create: (BuildContext context) => new GastronomyTypesBloc(),
      child: GastronomyTypesScreen(),
    );
  }
}
