import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/lookbook_instructions/lookbook_instructions_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LookBookInstructionsPage extends StatelessWidget {
  static const String routeName = "/lookbook-instructions";

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
        create: (BuildContext context) => ClothingBloc(),
        child: LookBookInstructionsScreen(),
      ),
    );
  }
}
