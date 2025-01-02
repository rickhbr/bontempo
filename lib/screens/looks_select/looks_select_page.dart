import 'package:bontempo/blocs/looks/looks_bloc.dart';
import 'package:bontempo/blocs/looks_schedule/looks_schedule_bloc.dart';
import 'package:bontempo/components/layout/layout_pushed.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/looks_select/looks_select_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LooksSelectPage extends StatelessWidget {
  final DateTime? date;
  final LooksScheduleBloc? looksScheduleBloc;

  const LooksSelectPage({Key? key, this.date, this.looksScheduleBloc})
      : super(key: key);

  static const String routeName = "/looks-select";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': '$routeName/${date!.toIso8601String().substring(0, 10)}',
        'screen_class': 'UpdateProfilePage',
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<LooksBloc>(
          create: (BuildContext context) => new LooksBloc(),
        ),
        BlocProvider<LooksScheduleBloc>.value(value: looksScheduleBloc!),
      ],
      child: LayoutPushed(
        child: LooksSelectScreen(date: date!),
      ),
    );
  }
}
