class Draft {
  int _id, _priority, _isStarred, _isArchived, _isTrash, _isDone;
  String _title, _description, _notes, _mdate, _ddate, _dtime;

  Draft(this._title, this._description, this._mdate, this._priority,
      this._isStarred, this._isArchived, this._isTrash, this._isDone,
      [this._notes, this._ddate, this._dtime]);

  Draft.withId(
      this._id,
      this._title,
      this._description,
      this._mdate,
      this._priority,
      this._isStarred,
      this._isArchived,
      this._isTrash,
      this._isDone,
      [this._notes,
      this._ddate,
      this._dtime]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get notes => _notes;
  String get mdate => _mdate;
  String get ddate => _ddate;
  String get dtime => _dtime;
  int get isStarred => _isStarred;
  int get isArchived => _isArchived;
  int get isTrash => _isTrash;
  int get isDone => _isDone;
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

  set notes(String newNotes) {
    if (newNotes.length <= 255) {
      this._notes = newNotes;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 0 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set isStarred(int newisStarred) {
    if (newisStarred == 1 || newisStarred == 0) {
      this._isStarred = newisStarred;
    }
  }

  set isArchived(int newisArchived) {
    if (newisArchived >= 1 && newisArchived <= 2) {
      this._isArchived = newisArchived;
    }
  }

  set isTrash(int newisTrash) {
    if (newisTrash >= 1 && newisTrash <= 2) {
      this._isTrash = newisTrash;
    }
  }

  set isDone(int newisDone) {
    if (newisDone >= 1 && newisDone <= 2) {
      this._isDone = newisDone;
    }
  }

  set mdate(String newMDate) {
    this._mdate = newMDate;
  }

  set ddate(String newDDate) {
    this._ddate = newDDate;
  }

  set dtime(String newDTime) {
    this._dtime = newDTime;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['notes'] = _notes;
    map['priority'] = _priority;
    map['mdate'] = _mdate;
    map['ddate'] = _ddate;
    map['dtime'] = _dtime;
    map['isStarred'] = _isStarred;
    map['isArchived'] = _isArchived;
    map['isTrash'] = _isTrash;
    map['isDone'] = _isDone;
    return map;
  }

  Draft.fromMapOject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._notes = map['notes'];
    this._priority = map['priority'];
    this._mdate = map['mdate'];
    this._ddate = map['ddate'];
    this._dtime = map['dtime'];
    this._isStarred = map['isStarred'];
    this._isArchived = map['isArchived'];
    this._isTrash = map['isTrash'];
    this._isDone = map['isDone'];
  }
}
