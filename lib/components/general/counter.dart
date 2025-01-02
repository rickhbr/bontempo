import 'dart:math';
import 'dart:async';

import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Counter extends StatefulWidget {
  final int quantity;
  final Function(int) callback;

  const Counter({
    Key? key,
    required this.quantity,
    required this.callback,
  }) : super(key: key);

  @override
  _CounterState createState() => _CounterState(quantity);
}

class _CounterState extends State<Counter> {
  int quantity;
  Timer? timerToUpdate;

  _CounterState(this.quantity);

  void decrease() {
    setState(() {
      quantity = max(0, quantity - 1);
    });
    updateQuantity();
  }

  void increase() {
    setState(() {
      quantity = quantity + 1;
    });
    updateQuantity();
  }

  void updateQuantity() {
    if (timerToUpdate != null && timerToUpdate!.isActive) {
      timerToUpdate!.cancel();
    }
    setState(() {
      timerToUpdate = Timer(Duration(milliseconds: 1000), () {
        widget.callback(quantity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setWidth(50),
          child: CommonButton(
            bordered: false,
            padding: EdgeInsets.zero,
            theme: CustomTheme.transparent,
            onTap: decrease,
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/circle-minus.svg',
                width: ScreenUtil().setWidth(21),
              ),
            ),
          ),
        ),
        Text(
          quantity.toString(),
          style: TextStyle(
            color: black[200],
            fontSize: ScreenUtil().setSp(17),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setWidth(50),
          child: CommonButton(
            bordered: false,
            padding: EdgeInsets.zero,
            theme: CustomTheme.transparent,
            onTap: increase,
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/circle-plus.svg',
                width: ScreenUtil().setWidth(21),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
