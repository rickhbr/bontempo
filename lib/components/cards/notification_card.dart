import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/notification_model.dart';
import 'package:bontempo/repositories/notification_repository.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationRepository _notificationRepository =
        new NotificationRepository();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      child: TextButton(
        onPressed: () async {
          _notificationRepository.readNotification(notification.code);

          if (notification.data['external_url'] != null) {
            if (await canLaunch(notification.data['external_url'])) {
              await launch(notification.data['external_url']);
            }
          } else if (notification.data['page'] != null) {
            if (notification.data['page'] == 'StockViewRoute') {
              Navigator.pushNamed(
                context,
                StockViewRoute,
              );
            }
          } else {
            Navigator.pushNamed(
              context,
              HomeViewRoute,
              arguments: HomeArguments(registerNotifications: false),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey[300]!,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(20),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                notification.title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(),
              Text(
                notification.text,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
