import 'package:bontempo/components/cards/recipe_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeRecipesCard extends StatelessWidget {
  final HomeModel home;

  const HomeRecipesCard({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (home.recipes != null && home.recipes.length > 0)
          ColumnTitle(
            theme: home.mode == HomeMode.day
                ? CustomTheme.black
                : CustomTheme.white,
            lightTitle: 'Confira as receitas com ingredientes',
            boldTitle: 'que você tem em casa.',
          ),
        if (home.recipes != null && home.recipes.length > 0)
          ListView.builder(
            shrinkWrap: true,
            itemCount: home.recipes.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return RecipeCard(
                recipe: home.recipes[index],
              );
            },
          ),
      ],
    );
  }
}
