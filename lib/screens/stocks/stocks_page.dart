import 'package:bontempo/blocs/cart/cart_bloc.dart';
import 'package:bontempo/blocs/stocks/stocks_bloc.dart';
import 'package:bontempo/components/layout/layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/stocks/stocks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksPage extends StatelessWidget {
  static const String routeName = "/stocks";

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
          BlocProvider<CartBloc>(
            create: (BuildContext context) => new CartBloc(),
          ),
          BlocProvider<StocksBloc>(
            create: (BuildContext context) => new StocksBloc(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: StocksScreen(),
        ),
      ),
    );
  }
}
