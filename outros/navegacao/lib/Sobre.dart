import 'package:flutter/material.dart';
import 'package:navegacao/Sobre.dart';
import 'package:navegacao/main.dart';

void main() {
  runApp(const Sobre());
}

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const paginaSobre(),
    );
  }
}

class paginaSobre extends StatelessWidget {
  const paginaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Aba Sobre!'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('ir para principal'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MyHomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}