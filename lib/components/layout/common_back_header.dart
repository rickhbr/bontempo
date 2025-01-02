import 'package:bontempo/components/buttons/circle_back_button.dart';
import 'package:bontempo/components/buttons/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBackHeader extends StatelessWidget {
  final TextAlign textAlign;
  final String title;

  const CommonBackHeader({
    Key? key,
    required this.title,
    textAlign,
  })  : this.textAlign = textAlign ?? TextAlign.center,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(18),
        vertical: ScreenUtil().setWidth(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircleBackButton(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(8),
                right: ScreenUtil().setWidth(8),
                top: ScreenUtil().setWidth(8),
              ),
              child: Text(
                this.title,
                textAlign: this.textAlign,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: -.5,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(27),
                ),
              ),
            ),
          ),
          NotificationButton(),
        ],
      ),
    );
  }
}
