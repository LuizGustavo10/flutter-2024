import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count1 = 0;
  int count2 = 0;
  int _secondsLeft = 60;
  late Timer _timer;
  bool _canClick = true;
  double _imagePosition = 0.0; // Posição inicial da imagem

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
          _canClick = false; // Desabilita os botões quando o tempo acabar
        }
      });
    });
  }

  void _restartTimer() {
    setState(() {
      _secondsLeft = 60;
      _canClick = true; // Habilita os botões novamente
      count1 = 0; // Reinicia o contador 1
      count2 = 0; // Reinicia o contador 2
      _imagePosition = 0.0; // Reinicia a posição da imagem
    });
    _timer.cancel();
    _startTimer();
  }

  void _updateImagePosition() {
    setState(() {
      _imagePosition = count1 > count2 ? 50.0 : MediaQuery.of(context).size.width - 150.0; // Define a posição da imagem com base nos cliques
    });
  }

  @override
  Widget build(BuildContext context) {
    Color colorCount1 = count1 > count2 ? Colors.red : Colors.black;
    Color colorCount2 = count2 > count1 ? Colors.red : Colors.black;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Flutter é divertido'),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Contador 1: $count1',
                    style: TextStyle(fontSize: 30, color: colorCount1),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contador 2: $count2', 
                    style: TextStyle(fontSize: 30, color: colorCount2),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(bottom: 120.0), // Espaço abaixo do texto "Tempo restante"
                    child: Text(
                      'Tempo restante: $_secondsLeft segundos',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              left: _imagePosition,
              bottom: 100.0, // Mantenha a distância do fundo da tela
              child: Image.network(
                'https://png.pngtree.com/png-vector/20220603/ourlarge/pngtree-pixel-art-character-wearing-suit-png-image_4843814.png',
                width: 100,
                height: 100,
              ),
            ),
            
          ],
        ),
        
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _canClick
                  ? () {
                      setState(() {
                        count1++;
                        _updateImagePosition(); // Atualiza a posição da imagem
                      });
                    }
                  : null, // Desabilita o botão se _canClick for falso
              tooltip: 'Incrementar contador 1',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: _restartTimer,
              tooltip: 'Zerar contagens',
              child: Icon(Icons.refresh),
            ),
            FloatingActionButton(
              onPressed: _canClick
                  ? () {
                      setState(() {
                        count2++;
                        _updateImagePosition(); // Atualiza a posição da imagem
                      });
                    }
                  : null, // Desabilita o botão se _canClick for falso
              tooltip: 'Incrementar contador 2',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}