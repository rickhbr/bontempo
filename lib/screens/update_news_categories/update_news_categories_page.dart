import 'package:bontempo/blocs/news_categories/news_categories_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:bontempo/screens/update_news_categories/update_news_categories_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNewsCategoriesPage extends StatelessWidget {
  static const String routeName = "/update-news";

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
      showHeader: true,
      title: 'Notícias',
      child: BlocProvider<NewsCategoriesBloc>(
        create: (BuildContext context) => new NewsCategoriesBloc(),
        child: UpdateNewsCategoriesScreen(),
      ),
    );
  }
}
