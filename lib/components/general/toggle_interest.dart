import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bontempo/theme/theme.dart';

class ToggleInterest extends StatelessWidget {
  final int id;
  final String title;
  final bool lock;
  final bool selected;
  final Function callback;
  final Color titleColor;

  ToggleInterest({
    Key? key,
    required this.id,
    required this.title,
    required this.callback,
    lock,
    selected,
    titleColor,
  })  : this.lock = lock ?? false,
        this.selected = selected ?? false,
        this.titleColor = titleColor ?? Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ButtonTheme(
        minWidth: double.infinity,
        height: ScreenUtil().setWidth(32) + ScreenUtil().setHeight(20),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(20),
          ),
          child: TextButton(
            onPressed: () {
              if (!lock) {
                callback(id);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      color: this.titleColor,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(54),
                  height: ScreenUtil().setWidth(32),
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                  ),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(2)),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(32)),
                    border: Border.all(
                      width: ScreenUtil().setWidth(1),
                      color: black[300]!,
                    ),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: 0,
                        left: selected ? ScreenUtil().setWidth(22) : 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: ScreenUtil().setWidth(26),
                          height: ScreenUtil().setWidth(26),
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(0),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected ? green[600] : Color(0xFF3E3E3E),
                          ),
                        ),
                      ),
                    ],
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
