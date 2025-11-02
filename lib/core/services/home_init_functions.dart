import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pasaportsmart/core/service/log.dart';
import 'package:pasaportsmart/core/service/notification.dart';
import 'package:pasaportsmart/screen/home_screen/home_screen.dart';

class HomeInitFunctions {
  late BuildContext context;

  init(context) {
    this.context = context;
    initNotification();
    onNotificationClick();
    checkUpdate();
  }

  Future<void> initNotification() async {
    notificationService = NotificationService(context);
    await notificationService.initNotification();
    await FirebaseMessaging.instance
        .subscribeToTopic('php_notification_pasaportsmart');
    FirebaseMessaging.onMessage.listen(foregroundMessageListener);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    await FirebaseMessaging.instance.getInitialMessage().then((initMessage) {
      LogService.logLn('initMessage: $initMessage');
      if (initMessage != null) {
        LogService.logLn('initMessage data: ${initMessage.data}');
        GoRouter.of(context).push(initMessage.data['page']);
      }
    });
  }

  Future<void> onNotificationClick() async {
    await notificationService.plugin.getNotificationAppLaunchDetails().then(
      (appLaunchDetail) {
        if (appLaunchDetail != null &&
            appLaunchDetail.didNotificationLaunchApp) {
          if (appLaunchDetail.notificationResponse != null &&
              appLaunchDetail.notificationResponse!.payload != null) {
            var json =
                jsonDecode(appLaunchDetail.notificationResponse!.payload!);
            if (json is Map) {
              var page = json['page'];
              if (page != null) {
                context.push(page);
              }
            }
          }
        }
      },
    );
  }

  Future<void> onMessageOpenedApp(RemoteMessage message) async {
    LogService.logLn('onMessageOpenedApp: data: ${message.data}');
    if (message.data['page'] != null) {
      LogService.logLn(
          'message data is not null \nnavigating: ${message.data['page']}');
      GoRouter.of(context).push(message.data['page']);
    }
  }

  Future<void> foregroundMessageListener(RemoteMessage message) async {
    LogService.logLn(
        '\x1B[31mforgroundMessageListener: ${jsonEncode(message.toMap())}');
    if (message.data.isNotEmpty) {
      notificationService.showNotification(
        id: 0,
        body: message.notification?.body,
        title: message.notification?.title,
        payload: jsonEncode(message.data),
      );
    } else {
      notificationService.showNotification(
        id: 0,
        body: message.notification?.body,
        title: message.notification?.title,
      );
    }
  }

  Future<void> checkUpdate() async {
    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((updateInfo) {
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          if (updateInfo.flexibleUpdateAllowed) {
            InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {
                InAppUpdate.completeFlexibleUpdate();
              }
            });
          }
        }
      });
    }
  }
}
