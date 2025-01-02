import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/clothes_add/clothes_add_screen.dart';

class ClothesAddPage extends StatelessWidget {
  static const String routeName = "/clothes-add";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );
    return ClothesAddScreen();
  }
}
