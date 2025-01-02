import 'package:bontempo/blocs/recipes/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/screens/recipes_details/recipes_details_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesDetailsPage extends StatelessWidget {
  final RecipeModel recipe;

  static const String routeName = "/recipes-details";

  const RecipesDetailsPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

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
      title: 'Receitas',
      child: BlocProvider<RecipesBloc>(
        create: (BuildContext context) => new RecipesBloc(),
        child: RecipesDetailsScreen(recipe: recipe),
      ),
    );
  }
}
