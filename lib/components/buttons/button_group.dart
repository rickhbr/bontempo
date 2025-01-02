import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGroup extends StatelessWidget {
  final List<Widget> buttons;

  const ButtonGroup({
    Key? key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setWidth(15),
      ),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(8),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: black[50]!,
          width: 1,
        ),
      ),
      child: Column(
        children: this.buttons,
      ),
    );
  }
}
