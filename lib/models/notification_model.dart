import 'package:flutter/foundation.dart';

class NotificationsModel {
  int id;
  String title, body;

  NotificationsModel(this.body, this.title);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['body'] = body;

    return map;
  }

  NotificationsModel.fromMapOject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.body = map['body'];
  }
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}