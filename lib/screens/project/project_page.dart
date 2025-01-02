import 'package:bontempo/blocs/project/project_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:bontempo/screens/project/project_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectPage extends StatelessWidget {
  static const String routeName = "/project";

  final ProjectModel model;

  ProjectPage(this.model);

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
      child: BlocProvider<ProjectBloc>(
        create: (BuildContext context) => new ProjectBloc(),
        child: ProjectScreen(model),
      ),
    );
  }
}
