import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/blocs/recipes/recipes_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/recipes/recipes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesPage extends StatelessWidget {
  static const String routeName = "/recipes";

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GastronomyTypesBloc>(
            create: (BuildContext context) => new GastronomyTypesBloc(),
          ),
          BlocProvider<RecipesBloc>(
            create: (BuildContext context) => new RecipesBloc(),
          ),
        ],
        child: RecipesScreen(),
      ),
    );
  }
}
