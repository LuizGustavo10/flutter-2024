import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Person {
  String id;
  String name;
  String phone;

  Person({required this.id, required this.name, required this.phone});

  factory Person.fromJson(String id, Map<String, dynamic> json) {
    return Person(
      id: id,
      name: json['name'],
      phone: json['phone'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> people = [];

  @override
  void initState() {
    super.initState();
    _fetchPeople();
  }

  Future<void> _fetchPeople() async {
    final url = Uri.parse(
        'https://senac-b0fdc-default-rtdb.firebaseio.com/people.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data != null) {
        data.forEach((id, personData) {
          setState(() {
            people.add(Person.fromJson(id, personData));
          });
        });
      }
    }
  }

  Future<void> _deletePerson(String id) async {
    final url = Uri.parse(
        'https://senac-b0fdc-default-rtdb.firebaseio.com/people/$id.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        people.removeWhere((person) => person.id == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App de Cadastro')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(person.name),
            subtitle: Text(person.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deletePerson(person.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CadastroPage(onPersonAdded: _fetchPeople)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CadastroPage extends StatefulWidget {
  final Function onPersonAdded;
  CadastroPage({required this.onPersonAdded});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _registerPerson() async {
    final url = Uri.parse(
        'https://senac-b0fdc-default-rtdb.firebaseio.com/people.json');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': _nameController.text,
        'phone': _phoneController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      widget.onPersonAdded();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Pessoas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerPerson,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
