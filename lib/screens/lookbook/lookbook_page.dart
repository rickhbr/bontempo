import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/lookbook/lookbook_screen.dart';

class LookBookPage extends StatelessWidget {
  static const String routeName = "/lookbook";

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
      child: LookBookScreen(),
    );
  }
}
