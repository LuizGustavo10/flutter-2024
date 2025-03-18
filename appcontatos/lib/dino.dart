import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(DinoGame());
}

class DinoGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double dinoY = 1; // Posição vertical do dino (1 = chão)
  double dinoGravity = 0.05; // Gravidade do pulo
  double dinoVelocity = 0; // Velocidade do dino
  bool isJumping = false;
  double cactusX = 1.5; // Posição inicial do cacto (fora da tela)
  int score = 0;
  bool gameOver = false;

  void startGame() {
    gameOver = false;
    score = 0;
    dinoY = 1;
    dinoVelocity = 0;
    cactusX = 1.5;
    
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        // Movimentação do cacto
        if (cactusX < -1) {
          cactusX = 1.5;
          score++;
        } else {
          cactusX -= 0.02;
        }

        // Movimento de queda do dino
        if (isJumping) {
          dinoVelocity -= dinoGravity;
          dinoY -= dinoVelocity;
        }

        // Parar o pulo ao tocar o chão
        if (dinoY > 1) {
          dinoY = 1;
          isJumping = false;
          dinoVelocity = 0;
        }

        // Detectar colisão
        if (cactusX < 0.2 && cactusX > -0.2 && dinoY >= 0.9) {
          gameOver = true;
          timer.cancel();
          _showGameOverDialog();
        }
      });
    });
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      dinoVelocity = 0.02;
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Pontuação: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: Text("Jogar Novamente"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jump,
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.blueAccent), // Fundo do jogo
            Align(
              alignment: Alignment(0, dinoY),
              child: Icon(Icons.android, size: 50, color: Colors.green),
            ),
            Align(
              alignment: Alignment(cactusX, 1),
              child: Icon(Icons.park, size: 50, color: Colors.brown),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Text("Score: $score", style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            if (gameOver)
              Center(
                child: Text(
                  "Game Over",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
