import 'package:flutter/material.dart';
import 'package:projeto_integrador_10/screen1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen(),
      routes: {
        '/screen1': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
        '/screen4': (context) => Screen4(),
        '/screen5': (context) => Screen5(),
        '/screen6': (context) => Screen6(),
        '/screen7': (context) => Screen7(),
        '/screen8': (context) => Screen8(),
        '/screen9': (context) => Screen9(),
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      backgroundColor: Colors.blue[900], // Cor de fundo azul escuro
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            botao(text: 'Screen 1', route: '/screen1', icon: Icons.home),
            botao(text: 'Screen 2', route: '/screen2', icon: Icons.search),
            botao(text: 'Screen 3', route: '/screen3', icon: Icons.settings),
            botao(text: 'Screen 4', route: '/screen4', icon: Icons.info),
            botao(text: 'Screen 5', route: '/screen5', icon: Icons.notifications),
            botao(text: 'Screen 6', route: '/screen6', icon: Icons.person),
            botao(text: 'Screen 7', route: '/screen7', icon: Icons.mail),
            botao(text: 'Screen 8', route: '/screen8', icon: Icons.shopping_cart),
            botao(text: 'Screen 9', route: '/screen9', icon: Icons.favorite),
          ],
        ),
      ),
    );
  }
}

class botao extends StatelessWidget {
  final String text;
  final String route;
  final IconData icon;

  const botao({Key? key, required this.text, required this.route, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Bordas levemente arredondadas
          ),
          primary: Colors.white, // Cor de fundo do botão
          onPrimary: Colors.blue, // Cor do ícone
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue, // Cor do ícone
              size: 40.0,
            ),
            SizedBox(height: 8), // Espaço entre o ícone e o texto
            Text(
              text,
              style: TextStyle(
                color: Colors.black, // Cor do texto
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Screen 2'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text('Screen 3'),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
      ),
      body: Center(
        child: Text('Screen 4'),
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 5'),
      ),
      body: Center(
        child: Text('Screen 5'),
      ),
    );
  }
}

class Screen6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 6'),
      ),
      body: Center(
        child: Text('Screen 6'),
      ),
    );
  }
}

class Screen7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 7'),
      ),
      body: Center(
        child: Text('Screen 7'),
      ),
    );
  }
}

class Screen8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 8'),
      ),
      body: Center(
        child: Text('Screen 8'),
      ),
    );
  }
}

class Screen9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 9'),
      ),
      body: Center(
        child: Text('Screen 9'),
      ),
    );
  }
}