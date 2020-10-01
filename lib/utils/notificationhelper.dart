import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  NotificationHelper() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializing();
  }

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

  getPlatformChannelSpecfics() {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    return notificationDetails;
  }

  void showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    await flutterLocalNotificationsPlugin.show(0, 'titleController.text',
        'descriptionController.text', getPlatformChannelSpecfics());
  }

  // void showNotificationsAfterSecond() async {
  //   await notificationAfterSec();
  // }

  Future<void> notificationAfterSec(
      int id, String title, String body, int hour, int minute) async {
    var timeDate =
        DateTime(2020, 9, 11, hour, minute).add(Duration(seconds: 5));

    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, timeDate, getPlatformChannelSpecfics());
  }

  void showNotificationDaily(
      int id, String title, String body, int hour, int minute) async {
    var time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics());
    print('Notification Succesfully Scheduled at ${time.toString()}');
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
}
