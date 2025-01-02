import 'package:bontempo/components/buttons/circle_back_button.dart';
import 'package:bontempo/components/buttons/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HeaderAppBar({Key? key, required this.title}) : super(key: key);

  Size get preferredSize {
    return new Size.fromHeight(55.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(18),
          top: ScreenUtil().setWidth(8),
          bottom: ScreenUtil().setWidth(8),
        ),
        child: CircleBackButton(),
      ),
      backgroundColor: Colors.white,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: ScreenUtil().setSp(22),
        ),
      ),
      titleSpacing: ScreenUtil().setWidth(10),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: ScreenUtil().setWidth(18),
            top: ScreenUtil().setWidth(8),
            bottom: ScreenUtil().setWidth(8),
          ),
          child: NotificationButton(),
        ),
      ],
      centerTitle: true,
    );
  }
}
