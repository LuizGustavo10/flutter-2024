import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/usuario.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      bool isValidUser = false;
      String userName = '';

      data.forEach((key, value) {
        if (value['email'] == email && value['password'] == password) {
          isValidUser = true;
          userName = value['name'];
        }
      });

      if (isValidUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuPage(userName: userName)),
        );
      } else {
        setState(() {
          _errorMessage = 'Email ou senha inválidos';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Erro ao conectar com a API';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela de Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Entrar'),
                  ),
            SizedBox(height: 16),
            _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage()),
                );
              },
              child: Text('Não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/usuario.json');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Erro ao cadastrar usuário';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Novo Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text('Cadastrar'),
                  ),
            SizedBox(height: 16),
            _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final String userName;

  MenuPage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, $userName!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastrarPostagemPage(userName: userName)),
                );
              },
              child: Text('Cadastrar Postagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerPostagensPage(userName: userName)),
                );
              },
              child: Text('Ver Postagens'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastrarPostagemPage extends StatefulWidget {
  final String userName;

  CadastrarPostagemPage({required this.userName});

  @override
  _CadastrarPostagemPageState createState() => _CadastrarPostagemPageState();
}

class _CadastrarPostagemPageState extends State<CadastrarPostagemPage> {
  final _postTitleController = TextEditingController();
  final _postContentController = TextEditingController();
  XFile? _image;
  final _picker = ImagePicker();

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    try {
      final ref = FirebaseStorage.instance.ref().child('post_images').child(DateTime.now().toString());
      final uploadTask = ref.putFile(File(_image!.path));

      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao enviar a imagem: $e');
      return null;
    }
  }

  Future<void> _addPost() async {
    final title = _postTitleController.text;
    final content = _postContentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final imageUrl = await _uploadImage();
      final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts.json');
      final response = await http.post(
        url,
        body: jsonEncode({
          'title': title,
          'content': content,
          'author': widget.userName,
          'imageUrl': imageUrl ?? '',
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerPostagensPage(userName: widget.userName)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Postagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _postTitleController,
              decoration: InputDecoration(labelText: 'Título da Postagem'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _postContentController,
              decoration: InputDecoration(labelText: 'Conteúdo da Postagem'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _image = pickedFile;
                  });
                }
              },
              child: Text('Escolher Imagem'),
            ),
            if (_image != null)
              Image.file(File(_image!.path), height: 150, fit: BoxFit.cover),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPost,
              child: Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerPostagensPage extends StatefulWidget {
  final String userName;

  VerPostagensPage({required this.userName});

  @override
  _VerPostagensPageState createState() => _VerPostagensPageState();
}

class _VerPostagensPageState extends State<VerPostagensPage> {
  List<Map<String, dynamic>> posts = [];

  Future<void> _fetchPosts() async {
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> loadedPosts = [];
      data.forEach((key, value) {
        loadedPosts.add({
          'title': value['title'],
          'content': value['content'],
          'author': value['author'],
          'imageUrl': value['imageUrl'] ?? '',
        });
      });

      setState(() {
        posts = loadedPosts;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Postagens')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (ctx, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(post['title']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Autor: ${post['author']}'),
                  SizedBox(height: 8),
                  Text(post['content']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
