import 'package:bontempo/blocs/climates/climates_bloc.dart';
import 'package:bontempo/blocs/clothing/clothing_bloc.dart';
import 'package:bontempo/blocs/clothing_categories/clothing_categories_bloc.dart';
import 'package:bontempo/blocs/clothing_colors/clothing_colors_bloc.dart';
import 'package:bontempo/blocs/clothing_styles/clothing_styles_bloc.dart';
import 'package:bontempo/components/layout/layout_pushed.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/clothes_edit/clothes_edit_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClothesEditPage extends StatelessWidget {
  final ClothingModel clothing;
  final ClothingBloc clothingBloc;

  static const String routeName = "/clothes-edit";

  const ClothesEditPage(
      {Key? key, required this.clothing, required this.clothingBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return LayoutPushed(
      child: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ClimatesBloc>(
              create: (BuildContext context) => ClimatesBloc(),
            ),
            BlocProvider<ClothingCategoriesBloc>(
              create: (BuildContext context) => ClothingCategoriesBloc(),
            ),
            BlocProvider<ClothingColorsBloc>(
              create: (BuildContext context) => ClothingColorsBloc(),
            ),
            BlocProvider<ClothingStylesBloc>(
              create: (BuildContext context) => ClothingStylesBloc(),
            ),
          ],
          child: ClothesEditScreen(
            clothing: this.clothing,
            clothingBloc: this.clothingBloc,
          ),
        ),
      ),
    );
  }
}
