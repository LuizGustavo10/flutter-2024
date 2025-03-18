import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

// Modelo de Pessoa
class Person {
  String id;
  String name;
  String phone;
  String email;

  Person({required this.id, required this.name, required this.phone, required this.email});

  factory Person.fromJson(String id, Map<String, dynamic> json) {
    return Person(
      id: id,
      name: json['name'],
      phone: json['phone'],
      email: json['email'] ?? '', // Caso não tenha e-mail, retorna string vazia
    );
  }
}

// Aplicativo Principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// Página Inicial
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
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/people.json');
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
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/people/$id.json');
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
      appBar: AppBar(title: Text('Lista de Contatos')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(person.name),
            subtitle: Text(person.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deletePerson(person.id),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailsPage(person: person),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPage(onPersonAdded: _fetchPeople)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Tela de Cadastro
class CadastroPage extends StatefulWidget {
  final Function onPersonAdded;
  CadastroPage({required this.onPersonAdded});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _registerPerson() async {
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/people.json');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
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
      appBar: AppBar(title: Text('Cadastro de Contato')),
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
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
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




/// Página de Detalhes do Contato
class ContactDetailsPage extends StatelessWidget {
  final Person person;

  ContactDetailsPage({required this.person});

  // Funções para abrir apps externos
  _callPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  _sendEmail(String email) async {
    final Uri emailUri = Uri(scheme: "mailto", path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  _openWhatsApp(String phone) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do Contato")),
      body: Center( // Centralizando a tela
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alinhando ao centro verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(person.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Telefone: ${person.phone}", style: TextStyle(fontSize: 18)),
              Text("E-mail: ${person.email}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 30),

              // Botões lado a lado
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(onPressed: () => _callPhone(person.phone), icon: Icon(Icons.phone), label: Text("Ligar")),
                  SizedBox(width: 10),
                  ElevatedButton.icon(onPressed: () => _sendEmail(person.email), icon: Icon(Icons.email), label: Text("E-mail")),
                  SizedBox(width: 10),
                  ElevatedButton.icon(onPressed: () => _openWhatsApp(person.phone), icon: Icon(Icons.message), label: Text("WhatsApp")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
