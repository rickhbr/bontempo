import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleBackButton extends StatelessWidget {
  final String route;
  CircleBackButton({this.route = ''});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ButtonTheme(
        minWidth: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(50),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () {
            if (route.isNotEmpty) {
              Navigator.pushNamed(context, route);
            } else {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(6)),
              height: ScreenUtil().setWidth(34),
              width: ScreenUtil().setWidth(34),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: ScreenUtil().setSp(15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
