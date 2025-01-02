import 'package:bontempo/blocs/library/library_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/library/library_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatelessWidget {
  static const String routeName = "/library";

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
      child: BlocProvider<LibraryBloc>(
        create: (BuildContext context) => new LibraryBloc(),
        child: LibraryScreen(),
      ),
    );
  }
}
