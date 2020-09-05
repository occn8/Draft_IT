import 'package:Draft_IT/index.dart';
import 'package:Draft_IT/models/todo_model.dart';

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
    await db.execute(
        'CREATE TABLE draftstable(id INTEGER PRIMARY KEY, title TEXT,description TEXT, priority INTEGER, date Text)');
    await db.execute(
        "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");
  }

  //fetch operation
  Future<List<Map<String, dynamic>>> getDraftMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query('draftstable', orderBy: 'priority ASC');
    return result;
  }

  //insert operation
  Future<int> insertDraft(Draft note) async {
    Database db = await this.database;
    var result = await db.insert('draftstable', note.toMap());
    return result;
  }

  //update operation
  Future<int> updateDraft(Draft note) async {
    Database db = await this.database;
    var result = await db.update('draftstable', note.toMap(),
        where: 'id =?', whereArgs: [note.id]);
    return result;
  }

  //delete operation
  Future<int> deleteDraft(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM draftstable WHERE id = $id');
    await db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
    return result;
  }

  //get no of items in db
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from draftstable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //get map list[list<map>] | convert it to notelist
  Future<List<Draft>> getDraftList() async {
    var draftMapList = await getDraftMapList();
    int count = draftMapList.length;
    List<Draft> draftList = List<Draft>();
    for (int i = 0; i < count; i++) {
      draftList.add(Draft.fromMapOject(draftMapList[i]));
    }
    return draftList;
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await this.database;
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodo(int taskId) async {
    Database db = await this.database;
    List<Map<String, dynamic>> todoMap =
        await db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]['id'],
          title: todoMap[index]['title'],
          draftId: todoMap[index]['taskId'],
          isDone: todoMap[index]['isDone']);
    });
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database db = await this.database;
    await db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }
}
