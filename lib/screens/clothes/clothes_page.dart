import 'package:bontempo/blocs/clothing/clothing_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/clothes/clothes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClothesPage extends StatelessWidget {
  static const String routeName = "/clothes";

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
      child: BlocProvider<ClothingBloc>(
        create: (BuildContext context) => new ClothingBloc(),
        child: ClothesScreen(),
      ),
    );
  }
}
