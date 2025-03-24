import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      final Map<String, dynamic>? data = jsonDecode(response.body);

      if (data != null) {
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
          _errorMessage = 'Nenhum dado encontrado';
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
            Icon(Icons.person, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
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
                ? Text(_errorMessage, style: TextStyle(color: Colors.red))
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
              child: Text('Ver Postagens de Todos'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MinhasPostagensPage(userName: userName)),
                );
              },
              child: Text('Ver Minhas Postagens'),
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
  final _imageUrlController = TextEditingController();

  Future<void> _addPost() async {
    final title = _postTitleController.text;
    final content = _postContentController.text;
    final imageUrl = _imageUrlController.text;

    if (title.isNotEmpty && content.isNotEmpty && imageUrl.isNotEmpty) {
      final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts.json');
      final response = await http.post(
        url,
        body: jsonEncode({
          'title': title,
          'content': content,
          'author': widget.userName,
          'imageUrl': imageUrl,
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
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPost,
              child: Text('Adicionar Postagem'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerPostagensPage extends StatelessWidget {
  final String userName;

  VerPostagensPage({required this.userName});

  Future<List<Map<String, dynamic>>> _fetchPosts() async {
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts.json');
    final response = await http.get(url);

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<Map<String, dynamic>> posts = [];
    data.forEach((key, value) {
      posts.add({
        'title': value['title'],
        'content': value['content'],
        'author': value['author'],
        'imageUrl': value['imageUrl'],
      });
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ver Postagens')),
      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: _fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar postagens'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Sem postagens para exibir'));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              final post = posts[index];
             
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    post['imageUrl'] == null ? SizedBox(): Image.network(post['imageUrl']), // Foto em cima
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(post['author'], style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MinhasPostagensPage extends StatelessWidget {
  final String userName;

  MinhasPostagensPage({required this.userName});

  Future<List<Map<String, dynamic>>> _fetchUserPosts() async {
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts.json');
    final response = await http.get(url);

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<Map<String, dynamic>> posts = [];
    data.forEach((key, value) {
      if (value['author'] == userName) {
        posts.add({
          'title': value['title'],
          'content': value['content'],
          'author': value['author'],
          'imageUrl': value['imageUrl'],
        });
      }
    });
    return posts;
  }
  
    Future<void> _deletePost(String postId) async {
    final url = Uri.parse('https://senac-b0fdc-default-rtdb.firebaseio.com/posts/$postId.json');
    await http.delete(url);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Postagens')),
      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: _fetchUserPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar postagens'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Você ainda não fez nenhuma postagem'));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              final post = posts[index];
 
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    post['imageUrl'] == null ? SizedBox(): Image.network(post['imageUrl']), // Foto em cima
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(post['author'], style: TextStyle(fontSize: 14, color: Colors.grey)),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
