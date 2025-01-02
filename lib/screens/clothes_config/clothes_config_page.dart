import 'package:bontempo/blocs/climates/index.dart';
import 'package:bontempo/blocs/clothing_add/clothing_add_bloc.dart';
import 'package:bontempo/blocs/clothing_categories/index.dart';
import 'package:bontempo/blocs/clothing_colors/index.dart';
import 'package:bontempo/blocs/clothing_styles/index.dart';
import 'package:bontempo/components/layout/layout_pushed.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/clothes_config/clothes_config_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClothesConfigPage extends StatelessWidget {
  final List images;
  static const String routeName = "/clothes-config";

  const ClothesConfigPage({Key? key, required this.images}) : super(key: key);

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
            BlocProvider<ClothingAddBloc>(
              create: (BuildContext context) => ClothingAddBloc(),
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
          child: ClothesConfigScreen(images: images),
        ),
      ),
    );
  }
}
