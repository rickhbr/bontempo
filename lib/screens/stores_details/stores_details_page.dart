import 'package:bontempo/blocs/stores_details/index.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/models/store_model.dart';
import 'package:bontempo/screens/stores_details/stores_details_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresDetailsPage extends StatelessWidget {
  static const String routeName = "/stores";

  final StoreModel store;

  StoresDetailsPage(this.store);

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
      child: BlocProvider<StoresDetailsBloc>(
        create: (BuildContext context) => StoresDetailsBloc(),
        child: StoresDetailsScreen(store),
      ),
    );
  }
}
