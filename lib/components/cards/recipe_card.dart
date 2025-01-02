import 'package:bontempo/components/cards/common_card.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/screens/recipes_details/recipes_details_arguments.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      buttonTitle: 'VER RECEITA',
      image: recipe.thumbnail,
      hideBrokenImage: true,
      title: recipe.title,
      icon: Icons.restaurant_menu,
      onTap: () {
        Navigator.pushNamed(
          context,
          RecipesDetailsViewRoute,
          arguments: RecipesDetailsArguments(recipe: recipe),
        );
      },
    );
  }
}
