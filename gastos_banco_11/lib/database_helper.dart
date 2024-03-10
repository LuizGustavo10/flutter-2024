// database_helper.dart

import 'dart:async';
import 'dart:io';
import 'package:gastos_banco_11/Espense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static late Database _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'expenses.db');

    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount REAL,
        date TEXT
      )
    ''');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await database;
    int id = await db.insert('expenses', expense.toMap());
    return id;
  }

  Future<List<Expense>> getExpenses() async {
    Database db = await database;
    List<Map> maps = await db.query('expenses', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
}