import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bontempo/theme/theme.dart';

class ToggleCheckbox extends StatelessWidget {
  final String title;
  final bool selected;
  final Function callback;

  ToggleCheckbox({
    Key? key,
    required this.title,
    required this.callback,
    selected,
  })  : this.selected = selected ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ButtonTheme(
        minWidth: double.infinity,
        height: ScreenUtil().setWidth(50),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(15),
          ),
          child: TextButton(
            onPressed: () {
              callback();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setWidth(20),
                  margin: EdgeInsets.only(
                    right: ScreenUtil().setWidth(8),
                  ),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: ScreenUtil().setWidth(1),
                      color: black,
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: ScreenUtil().setWidth(selected ? 8 : 0),
                        height: ScreenUtil().setWidth(selected ? 8 : 0),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
