import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class LayoutGuest extends StatelessWidget {
  final Widget child;
  final Widget? bottomBar;

  const LayoutGuest({
    Key? key,
    required this.child,
    this.bottomBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: black,
        child: this.child,
      ),
      bottomNavigationBar: this.bottomBar ?? null,
    );
  }
}
