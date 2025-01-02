import 'package:flutter/material.dart';

import 'package:bontempo/screens/no_connection/no_connection_screen.dart';

class NoConnectionPage extends StatelessWidget {
  static const String routeName = "/no-connection";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoConnectionScreen(),
    );
  }
}
