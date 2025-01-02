import 'package:bontempo/components/layout/header_app_bar.dart';
import 'package:bontempo/components/layout/drawer_menu.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class LayoutWebview extends StatelessWidget {
  final Widget child;
  final String title;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LayoutWebview({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      endDrawer: DrawerMenu(),
      appBar: HeaderAppBar(
        title: title,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: white,
        child: this.child,
      ),
    );
  }
}
