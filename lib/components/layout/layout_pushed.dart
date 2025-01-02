import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class LayoutPushed extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? header;
  final Widget? footer;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LayoutPushed({
    Key? key,
    required this.child,
    this.footer,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      bottomNavigationBar: this.footer,
      appBar: this.header,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: white,
        child: this.child,
      ),
    );
  }
}
