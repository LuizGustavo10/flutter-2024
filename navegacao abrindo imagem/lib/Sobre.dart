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
      body: Hero(
        tag: 'https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg',
        child: Image.network(
        'https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg',
        height: 700, // Defina o tamanho desejado aqui
        width: 700,
        ),
      ),
      
    );
  }
}