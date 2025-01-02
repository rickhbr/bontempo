import 'package:bontempo/blocs/home/home_bloc.dart';
import 'package:bontempo/blocs/home/home_event.dart';
import 'package:bontempo/blocs/home_look/home_look_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/providers/notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bontempo/screens/home/home_screen.dart';

class HomePage extends StatelessWidget {
  final bool registerNotifications;
  static const String routeName = "/home";

  const HomePage({
    Key? key,
    required this.registerNotifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': routeName,
        'screen_class': 'UpdateProfilePage',
      },
    );

    if (registerNotifications) {
      Notifications.firebaseCloudMessagingListeners(context);
    }

    return Layout(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc()..add(LoadHomeEvent()),
          ),
          BlocProvider<HomeLookBloc>(
            create: (BuildContext context) => HomeLookBloc(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
