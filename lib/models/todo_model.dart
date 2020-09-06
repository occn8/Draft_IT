class Todo {
  int id;
  int draftId;
  String title;
  int isDone;
  Todo({this.id, this.draftId, this.title, this.isDone});

  //convert note object into map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }

    map['draftId'] = draftId;
    map['title'] = title;
    map['priority'] = isDone;

    return map;
  }

  //extract note obj from map obj
  Todo.fromMapOject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.draftId = map['draftId'];
    this.title = map['title'];
    this.isDone = map['isDone'];
  }
}
