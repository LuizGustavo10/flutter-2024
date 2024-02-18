import 'package:sqflite/sq34flite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, completed INTEGER)",
        );
      },
    );
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    Database db = await this.database;
    return await db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await this.database;
    return await db.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    Database db = await this.database;
    return await db.update('tasks', task,
        where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}