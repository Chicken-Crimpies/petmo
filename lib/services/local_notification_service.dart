
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();



  static void initialize(BuildContext context){
    /// Change the string to change the icon that pops up
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? route) async{
      if (route != null){
        Navigator.of(context).pushNamed(route);
      }

    });
  }

  static void display(RemoteMessage message) async{

    var random = Random();

    try {
      final id = random.nextInt(pow(2, 31).toInt() - 1);

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "petmo",
            "petmo channel",
            "this is our channel",
            importance: Importance.max,
            priority: Priority.high,
          )
      );

      await _notificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["route"]
      );
    } on Exception catch (e) {
      print(e);
    }


  }

}