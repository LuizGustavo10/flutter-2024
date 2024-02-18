import 'package:flutter/material.dart';
import 'package:navegacao/Sobre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Flutter rodou!'),
      ),
      body: IconButton(
        icon : Hero(
          tag: 'https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg',
          child: Image.network(
            'https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg',
            height: 50, // Defina o tamanho desejado aqui
            width: 50,
            ),

        ),

          // icon: Image.network(
          //   'https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg',
          //   height: 50, // Defina o tamanho desejado aqui
          //   width: 50,
          //   ),
          iconSize: 50,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const paginaSobre(),
              ),
            );
          },
        ),
    
    );
  }
}