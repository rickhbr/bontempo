import 'package:bontempo/blocs/notifications/notifications_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/notifications/notifications_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  static const String routeName = "/notifications";

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationBloc>(
            create: (BuildContext context) => new NotificationBloc(),
          ),
        ],
        child: NotificationsScreen(),
      ),
    );
  }
}
