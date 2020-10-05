import 'package:Draft_IT/index.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper; //singleton dbhelper
  static Database _database; //singleton db

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'drafts.db';
    var draftsDb = openDatabase(path, version: 1, onCreate: _createDb);
    return draftsDb;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE draftstable(id INTEGER PRIMARY KEY, 
        title TEXT,description TEXT, notes TEXT, priority INTEGER, 
        mdate Text, ddate Text, dtime Text, isStarred INTEGER, 
        isArchived INTEGER, isTrash INTEGER, isDone INTEGER)
        ''');
    await db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, draftId INTEGER, title TEXT, isDone INTEGER)');
    await db.execute('CREATE TABLE tags(id INTEGER PRIMARY KEY, name TEXT)');
    await db.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT)');

    await db.rawInsert(
        'INSERT INTO tags(id, name) VALUES(1, "Work"),VALUES(2, "Personal")');
  }

//Drafts
  Future<int> insertDraft(Draft draft) async {
    int draftId = 0;
    Database db = await this.database;
    // var result =
    await db
        .insert('draftstable', draft.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => draftId = value);
    return draftId;
  }

  Future<int> updateDraft(Draft draft) async {
    Database db = await this.database;
    var result = await db.update('draftstable', draft.toMap(),
        where: 'id =?', whereArgs: [draft.id]);
    return result;
  }

  Future<int> deleteDraft(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM draftstable WHERE id = $id');
    // await db.rawDelete("DELETE FROM todos WHERE taskId = '$id'");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from draftstable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Map<String, dynamic>>> getDraftMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM draftstable order by id DESC, priority ASC');
    var result = await db.query(
      'draftstable',
      orderBy: 'priority DESC, id ASC',
      where: 'isTrash=0',
    );
    return result;
  }

  Future<List<Draft>> getDraftList() async {
    var draftMapList = await getDraftMapList();
    int count = draftMapList.length;
    List<Draft> draftList = List<Draft>();
    for (int i = 0; i < count; i++) {
      draftList.add(Draft.fromMapOject(draftMapList[i]));
    }
    return draftList;
  }

  Future<List<Map<String, dynamic>>> getFilteredDraftMapList(
      String isWhat) async {
    Database db = await this.database;
    var result = isWhat == 'isTrash'
        ? await db.rawQuery("SELECT * FROM draftstable WHERE $isWhat=1")
        : await db.rawQuery(
            "SELECT * FROM draftstable WHERE $isWhat=1 AND isTrash=0");
    return result;
  }

  Future<List<Draft>> getFilteredDraftList(String isWhat) async {
    var draftMapList = await getFilteredDraftMapList(isWhat);
    int count = draftMapList.length;
    List<Draft> draftList = List<Draft>();
    for (int i = 0; i < count; i++) {
      draftList.add(Draft.fromMapOject(draftMapList[i]));
    }
    return draftList;
  }

  Future<void> toggleIsDone(int id, int isDone) async {
    Database db = await this.database;
    await db.rawUpdate(
        "UPDATE draftstable SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<void> toggleIsStarred(int id, int isStarred) async {
    Database db = await this.database;
    await db.rawUpdate(
        "UPDATE draftstable SET isStarred = '$isStarred' WHERE id = '$id'");
  }

  Future<void> toggleIsArchived(int id, int isArchived) async {
    Database db = await this.database;
    await db.rawUpdate(
        "UPDATE draftstable SET isArchived = '$isArchived' WHERE id = '$id'");
  }

  Future<void> toggleIsTrash(int id, int isTrash) async {
    Database db = await this.database;
    await db.rawUpdate(
        "UPDATE draftstable SET isTrash = '$isTrash' WHERE id = '$id'");
  }

//ToDo
  Future<void> insertTodo(Todo todo) async {
    Database db = await this.database;
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Future<List<Todo>> getTodo(int taskId) async {
  //   Database db = await this.database;
  //   List<Map<String, dynamic>> todoMap =
  //       await db.rawQuery("SELECT * FROM todos WHERE taskId = $taskId");
  //   return List.generate(todoMap.length, (index) {
  //     return Todo(
  //         // id: todoMap[index]['id'],
  //         title: todoMap[index]['title'],
  //         // draftId: todoMap[index]['taskId'],
  //         isDone: todoMap[index]['isDone']);
  //   });
  // }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database db = await this.database;
    await db.rawUpdate("UPDATE todos SET isDone = '$isDone' WHERE id = '$id'");
  }

//Tags
  Future<int> insertTag(Tag tag) async {
    Database db = await this.database;
    var result = await db.insert('tags', tag.toMap());
    return result;
  }

  Future<int> updateTag(Tag tag) async {
    Database db = await this.database;
    var result = await db
        .update('tags', tag.toMap(), where: 'id =?', whereArgs: [tag.id]);
    return result;
  }

  Future<int> deleteTag(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM tags WHERE id = $id');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTagMapList() async {
    Database db = await this.database;
    var result = await db.query('tags');
    return result;
  }

  Future<List<Tag>> getTagList() async {
    var tagMapList = await getTagMapList();
    int count = tagMapList.length;
    List<Tag> tagList = List<Tag>();
    for (int i = 0; i < count; i++) {
      tagList.add(Tag.fromMapOject(tagMapList[i]));
    }
    return tagList;
  }

  //Notifications
  Future<int> insertNF(NotificationsModel nf) async {
    int nfId = 0;
    Database db = await this.database;
    await db
        .insert('notifications', nf.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => nfId = value);
    return nfId;
  }

  Future<int> updateNF(NotificationsModel nf) async {
    Database db = await this.database;
    var result = await db.update('notifications', nf.toMap(),
        where: 'id =?', whereArgs: [nf.id]);
    return result;
  }

  Future<int> deleteNF(NotificationsModel id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM notifications WHERE id = $id');
    return result;
  }

  Future<List<Map<String, dynamic>>> getNFMapList() async {
    Database db = await this.database;
    var result = await db.query('notifications');
    return result;
  }

  Future<List<Tag>> getNFList() async {
    var nfMapList = await getNFMapList();
    int count = nfMapList.length;
    List<Tag> nfList = List<Tag>();
    for (int i = 0; i < count; i++) {
      nfList.add(Tag.fromMapOject(nfMapList[i]));
    }
    return nfList;
  }
}
