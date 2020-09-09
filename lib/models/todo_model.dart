class Todo {
  int id;
  int draftId;
  String title;
  int isDone;
  Todo({
    this.id,
    this.draftId,
    this.title,
    this.isDone,
  });

  int get todoId => id;
  int get todoDraftId => draftId;
  String get todoTitle => title;
  int get todoisDone => isDone;

  set todoDraftId(int draftId) {
    if (draftId >= 1 && draftId <= 2) {
      this.id = draftId;
    }
  }

  set todoTitle(String title) {
    if (title.length <= 255) {
      this.title = title;
    }
  }

  set todoisDone(int isdone) {
    if (isdone >= 1 && isdone <= 2) {
      this.isDone = isdone;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }

    map['draftId'] = draftId;
    map['title'] = title;
    map['isDone'] = isDone;

    return map;
  }

  Todo.fromMapOject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.draftId = map['draftId'];
    this.title = map['title'];
    this.isDone = map['isDone'];
  }
}
