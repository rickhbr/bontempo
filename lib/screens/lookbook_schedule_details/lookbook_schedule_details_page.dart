import 'package:bontempo/blocs/events/index.dart';
import 'package:bontempo/blocs/looks_schedule/looks_schedule_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/lookbook_schedule_details/lookbook_schedule_details_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LookBookScheduleDetailsPage extends StatelessWidget {
  final DateTime? date;

  const LookBookScheduleDetailsPage({Key? key, this.date}) : super(key: key);

  static const String routeName = "/lookbook-schedule-details";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': '$routeName/${date!.toIso8601String().substring(0, 10)}',
        'screen_class': 'UpdateProfilePage',
      },
    );

    return Layout(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EventsBloc>(
            create: (BuildContext context) => new EventsBloc(),
          ),
          BlocProvider<LooksScheduleBloc>(
            create: (BuildContext context) => new LooksScheduleBloc(),
          ),
        ],
        child: LookBookScheduleDetailsScreen(date: this.date!),
      ),
    );
  }
}
