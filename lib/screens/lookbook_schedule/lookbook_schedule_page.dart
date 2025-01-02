import 'package:bontempo/blocs/events/events_bloc.dart';
import 'package:bontempo/blocs/looks_schedule/looks_schedule_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/lookbook_schedule/lookbook_schedule_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LookBookSchedulePage extends StatelessWidget {
  static const String routeName = "/lookbook-schedule";

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
          BlocProvider<LooksScheduleBloc>(
            create: (BuildContext context) => new LooksScheduleBloc(),
          ),
          BlocProvider<EventsBloc>(
            create: (BuildContext context) => new EventsBloc(),
          ),
        ],
        child: LookBookScheduleScreen(),
      ),
    );
  }
}
