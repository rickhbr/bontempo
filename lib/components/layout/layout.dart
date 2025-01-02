import 'package:bontempo/components/layout/header_app_bar.dart';
import 'package:bontempo/components/layout/drawer_menu.dart';
import 'package:bontempo/components/layout/footer.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  bool? showHeader = false;
  String? title = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Layout({
    Key? key,
    required this.child,
    this.showHeader,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      endDrawer: DrawerMenu(),
      appBar: showHeader != null && showHeader!
          ? HeaderAppBar(
              title: title!,
            )
          : null,
      bottomNavigationBar: Footer(scaffoldKey: _scaffoldKey),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: white,
        child: this.child,
      ),
    );
  }
}
