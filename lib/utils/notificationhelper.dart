import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings androidInitializationSettings;
IOSInitializationSettings iosInitializationSettings;
InitializationSettings initializationSettings;

void initializing() async {
  androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  initializationSettings = InitializationSettings(
      androidInitializationSettings, iosInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

void showNotifications() async {
  await notification();
}

Future<void> notification() async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('Channel ID', 'Channel title', 'channel body',
          priority: Priority.High, importance: Importance.Max, ticker: 'test');

  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  await flutterLocalNotificationsPlugin.show(0, 'titleController.text',
      'descriptionController.text', notificationDetails);
}

void showNotificationsAfterSecond() async {
  await notificationAfterSec();
}

Future<void> notificationAfterSec() async {
  var timeDelayed = DateTime(2020, 9, 11, 22, 15).add(Duration(seconds: 5));
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'second channel ID', 'second Channel title', 'second channel body',
          priority: Priority.High, importance: Importance.Max, ticker: 'test');

  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
      'please subscribe my channel', timeDelayed, notificationDetails);
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
