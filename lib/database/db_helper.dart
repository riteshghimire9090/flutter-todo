import 'package:flutterloginwithtodo/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  final String tableTodo = "todoTable";
  final String colId = 'id';
  final String colNote = "note";
  final String colColor = "color";

  static Database _db;

  DBHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print('----------------------------------');
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "todo.db");

    var db = openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableTodo( '
        '$colId INTEGER PRIMARY KEY, '
        '$colColor TEXT,'
        '$colNote TEXT)');
  }

  Future<int> saveTodo(Todo todo) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableTodo, todo.toJson());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
    print(result);
    return result;
  }

  Future<List<Todo>> getAllTodo() async {
    var dbClient = await db;
    var result =
        await dbClient.query(tableTodo, columns: [colId, colNote, colColor]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
    print(result.toString());
    print(result.runtimeType);
    result = result.toList();
    List<Todo> todoList = [];

    result.forEach((element) {
      Todo todo = Todo(
        id: element['id'],
        note: element['note'],
        color: element['color'],
      );

      todoList.add(todo);
    });

    return todoList;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableTodo'));
  }

  Future<Todo> getTodo(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableTodo,
        columns: [colId, colNote, colColor],
        where: '$colId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Todo.fromJson(result.first);
    }

    return null;
  }

  Future<int> deleteTodo(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableTodo, where: '$colId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateTodo(Todo todo) async {
    var dbClient = await db;
    return await dbClient.update(tableTodo, todo.toJson(),
        where: "$colId = ?", whereArgs: [todo.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
