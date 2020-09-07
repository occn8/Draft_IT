class Draft {
  int _id, _priority, _isStarred, _isArchived, _isTrash, _isDone;
  String _title, _description, _mdate, _ddate;

  Draft(this._title, this._mdate, this._ddate, this._priority, [this._description]);

  Draft.withId(this._id, this._title, this._mdate, this._ddate, this._priority,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get mdate => _mdate;
  String get ddate => _ddate;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set mdate(String newMDate) {
    this._mdate = newMDate;
  }
  set ddate(String newDDate) {
    this._ddate = newDDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['mdate'] = _mdate;
    map['ddate'] = _ddate;

    return map;
  }

  Draft.fromMapOject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._mdate = map['mdate'];
    this._ddate = map['ddate'];
  }
}
