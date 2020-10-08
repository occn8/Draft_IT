import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// final BehaviorSubject<NotificationsModel> didReceiveLocalNotificationSubject =
//     BehaviorSubject<NotificationsModel>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  var iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, iosInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
}

getPlatformChannelSpecfics() {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('channel ID', 'Channel title', 'channel body',
          priority: Priority.High,
          importance: Importance.Max,
          ticker: 'draft nf');

  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  return notificationDetails;
}

Future<void> notification() async {
  await flutterLocalNotificationsPlugin.show(0, 'titleController.text',
      'descriptionController.text', getPlatformChannelSpecfics());
}

Future<void> notificationSchedule(
    int id, String title, String body, int hour, int minute) async {
  var timeDate = DateTime(2020, 10, 8, hour, minute);

  await flutterLocalNotificationsPlugin.schedule(
      id, title, body, timeDate, getPlatformChannelSpecfics());
}

void showNotificationDaily(
    int id, String title, String body, int hour, int minute) async {
  var time = new Time(hour, minute, 0);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      id, title, body, time, getPlatformChannelSpecfics());
  print('Notification Succesfully Scheduled at ${time.hour.toString()}'+title);
}

Future onSelectNotification(String payLoad) {
  if (payLoad != null) {
    print(payLoad);
  }
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(body),
    actions: <Widget>[
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print("");
          },
          child: Text("Okay")),
    ],
  );
}

void removeNotification(int notificationId) {
  flutterLocalNotificationsPlugin.cancel(notificationId);
}

void removeAllNotification() {
  flutterLocalNotificationsPlugin.cancelAll();
}
