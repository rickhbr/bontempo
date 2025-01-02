import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/repositories/notification_repository.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationButton extends StatelessWidget {
  final NotificationRepository _notificationRepository =
      new NotificationRepository();

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
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(38),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, NotificationsViewRoute);
          },
          child: Container(
            height: ScreenUtil().setWidth(50),
            width: ScreenUtil().setWidth(50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/notification.svg',
                  height: ScreenUtil().setWidth(29),
                  width: ScreenUtil().setWidth(23),
                ),
                Positioned(
                  top: ScreenUtil().setWidth(8),
                  right: ScreenUtil().setWidth(1),
                  child: Container(
                    height: ScreenUtil().setWidth(20),
                    width: ScreenUtil().setWidth(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: black,
                    ),
                    child: Center(
                      child: Text(
                        _notificationRepository.unread.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
