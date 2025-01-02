import 'dart:io';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/repositories/notification_repository.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Notifications {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static void firebaseCloudMessagingListeners(BuildContext context) {
    NotificationRepository notificationRepository = NotificationRepository();
    notificationRepository.getNotifications();

    if (Platform.isIOS) {
      Notifications.iOSPermission();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      NotificationRepository notificationRepository = NotificationRepository();

      print('FIREBASE NOTIFICATION :::::::::::: on message $message');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !Platform.isIOS) {
        notificationRepository.readNotification(message.data['code']);

        // Bugfix/gambiarra pra contornar problema do firebase de receber notificação duas vezes
        if (!notificationRepository.notificationIsOpened) {
          notificationRepository.notificationIsOpened = true;
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: notification.title ?? '',
              description: notification.body ?? '',
              buttonText: "Abrir",
              callback: () {
                notificationRepository.notificationIsOpened = false;
                Notifications.handleNotification(context, message.data);
              },
              cancelCallback: () {
                notificationRepository.notificationIsOpened = false;
              },
              cancelText: 'Fechar',
            ),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('FIREBASE NOTIFICATION :::::::::::: on resume $message');
      Notifications.handleNotification(context, message.data);
    });

    // A linha abaixo foi removida porque o registro do callback de mensagens de fundo deve ser feito no main.dart
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void handleNotification(
    BuildContext context,
    Map<String, dynamic> notification,
  ) async {
    if (context == null) {
      return;
    }

    NotificationRepository notificationRepository = NotificationRepository();

    notificationRepository.readNotification(notification['code']);

    if (notification['external_url'] != null) {
      if (await canLaunch(notification['external_url'])) {
        await launch(notification['external_url']);
      }
    } else if (notification['page'] != null) {
      if (notification['page'] == 'StockViewRoute') {
        navigatorKey.currentState!.pushNamed(
          StockViewRoute,
        );
      }
    } else {
      navigatorKey.currentState!.pushNamed(
        HomeViewRoute,
        arguments: HomeArguments(registerNotifications: false),
      );
    }
  }

  static void iOSPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Settings registered: $settings");
  }
}
