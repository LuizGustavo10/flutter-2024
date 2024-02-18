import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Inicialize o databaseFactory antes de chamar runApp()
  sqfliteFfiInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Future<Database> _database;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _database = _openDatabase();
  }

  Future<Database> _openDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_list.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, completed INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> _insertTodo(String title) async {
    final Database db = await _database;
    await db.insert(
      'todos',
      {'title': title, 'completed': 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> _getTodos() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        completed: maps[i]['completed'] == 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  trailing: Checkbox(
                    value: snapshot.data![index].completed,
                    onChanged: (bool? value) {
                      // Atualizar a tarefa como concluída ou não concluída no banco de dados
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? newTodo = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Todo'),
                content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Enter todo title'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      Navigator.of(context).pop(_textController.text);
                    },
                  ),
                ],
              );
            },
          );
          if (newTodo != null) {
            await _insertTodo(newTodo);
            _textController.clear();
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });
  }