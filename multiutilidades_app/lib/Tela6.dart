import 'dart:async';
import 'package:flutter/material.dart';

class Tela6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => calcular();
}

class calcular extends State<Tela6> {
  int segundos = 0;
  bool ativo = false;
  late Timer timer;
  TextEditingController tempo = TextEditingController();

  //preenher input de minutos por padrão
  @override
  void initState() {
    super.initState();
    tempo.text = "1";
  }

  void atualizarTempo(Timer timer) {
    if (ativo && segundos > 0) {
      setState(() {
        segundos = segundos - 1;
      });
    } else {
      iniciarCancelarTimer();
    }
  }

  void iniciarCancelarTimer() {
    setState(() {
      ativo = !ativo;
      if (ativo) {
        segundos = (int.tryParse(tempo.text) ?? 0) * 60;
        timer = Timer.periodic(Duration(seconds: 1), atualizarTempo);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //alimenta a animação de carregamento  30  / (1*60)
    double progresso = segundos / ((int.tryParse(tempo.text) ?? 1) * 60);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: CircularProgressIndicator(
                  value: progresso.isNaN ? 0.0 : progresso,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 150,
                ),
              ),
              width: 150,
              height: 200,
            ),
            TextField(
              controller: tempo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tempo (minutos)'),
              enabled: !ativo,
            ),
            SizedBox(height: 20),
            //exibindo minutos, converte pra texto, se for um número, preeche zero a esquerda
            Text(
                '${(segundos ~/ 60).toString().padLeft(2, '0')}:${(segundos % 60).toString().padLeft(2, '0')} ',
                style: TextStyle(fontSize: 60, color: Colors.blue)),

            SizedBox(width: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: iniciarCancelarTimer,
                  child: ativo ? Text('Desistir') : Text('Iniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
