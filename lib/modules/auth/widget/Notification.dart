import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screen/air.dart';

      class Noti{
    static  Future initializeNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');



    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,

    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  }