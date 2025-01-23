import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Despesas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseListScreen(),
    );
  }
}

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late Future<Database> _database;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  List<Map<String, dynamic>> _expenses = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'expense_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, amount REAL)',
        );
      },
      version: 1,
    );
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> expenses = await db.query('expenses');
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _insertExpense(String description, double amount) async {
    final Database db = await _database;
    await db.insert(
      'expenses',
      {'description': description, 'amount': amount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _fetchExpenses();
  }

  Future<void> _deleteExpense(int id) async {
    final Database db = await _database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchExpenses();
  }

  double _calculateTotalExpenses() {
    double total = 0;
    for (var expense in _expenses) {
      total += expense['amount'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Despesas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.blue,
            child: Text(
              'Total de Gastos: \$${_calculateTotalExpenses().toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_expenses[index]['description']),
                  subtitle: Text('\$${_expenses[index]['amount']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteExpense(_expenses[index]['id']);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Valor'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _insertExpense(
                      _descriptionController.text,
                      double.tryParse(_amountController.text) ?? 0.0,
                    );
                    _descriptionController.clear();
                    _amountController.clear();
                  },
                  child: Text('Adicionar Despesa'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}