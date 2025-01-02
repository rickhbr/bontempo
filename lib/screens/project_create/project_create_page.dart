import 'package:bontempo/blocs/project_create/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/project_create/project_create_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCreatePage extends StatelessWidget {
  static const String routeName = "/project-create";

  final int storeId;
  ProjectCreatePage(this.storeId);

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
      child: BlocProvider<ProjectCreateBloc>(
        create: (BuildContext context) => ProjectCreateBloc(),
        child: ProjectCreateScreen(storeId),
      ),
    );
  }
}
