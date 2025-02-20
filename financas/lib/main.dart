import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Person {
  String name;
  String phone;

  Person(this.name, this.phone);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Person> people = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardButton(
              title: 'Cadastro de Pessoas',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage(people: people)),
                );
              },
            ),
            SizedBox(height: 20),
            CardButton(
              title: 'Lista de Pessoas',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabelaPage(people: people)),
                );
              },
            ),
            SizedBox(height: 20),
            CardButton(
              title: 'Sobre',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SobrePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CardButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(title, textAlign: TextAlign.center),
        onTap: onPressed,
      ),
    );
  }
}

class CadastroPage extends StatefulWidget {
  final List<Person> people;

  CadastroPage({required this.people});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
      ),
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
              onPressed: () {
                setState(() {
                  widget.people.add(Person(_nameController.text, _phoneController.text));
                  _nameController.clear();
                  _phoneController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
} 

class TabelaPage extends StatelessWidget {
  final List<Person> people;

  TabelaPage({required this.people});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pessoas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(people[index].name),
              subtitle: Text(people[index].phone),
            );
          },
        ),
      ),
    );
  }
}

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Este é um aplicativo simples para cadastro de pessoas, exibindo nome e telefone.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
