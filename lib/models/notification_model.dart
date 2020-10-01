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
