import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class TodoService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  Future<void> addTodo(TodoModel todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap());
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
