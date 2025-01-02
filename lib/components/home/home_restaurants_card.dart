import 'package:bontempo/components/cards/restaurants_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeRestaurantsCard extends StatelessWidget {
  final HomeModel home;

  const HomeRestaurantsCard({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (home.restaurantCard!.restaurants != null &&
            home.restaurantCard!.restaurants.length > 0)
          ColumnTitle(
            theme: home.mode == HomeMode.day
                ? CustomTheme.black
                : CustomTheme.white,
            lightTitle: 'Caso não queira cozinhar',
            boldTitle: 'vá até seu restaurante preferido!',
          ),
        if (home.restaurantCard!.restaurants != null &&
            home.restaurantCard!.restaurants.length > 0)
          RestaurantsCard(
            restaurantsCard: home.restaurantCard!,
          ),
      ],
    );
  }
}
