import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro/Temporizador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  late Timer _timer;
  int _segundos = 0;
  bool _ativo = false;
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timeController.text = "1"; // Valor padrão inicial de 1 minuto
  }

  void _updateTimer(Timer timer) {
    if (_ativo && _segundos > 0) {
      setState(() {
        _segundos -= 1;
      });
    } else {
      _toggleTimer(); // Pausar quando o tempo chegar a zero
    }
  }

  void _toggleTimer() {
    setState(() {
      _ativo = !_ativo;
      if (_ativo) {
        _segundos = (int.tryParse(_timeController.text) ?? 0) * 60; // Converter minutos para segundos
        _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
      } else {
        _timer.cancel();
      }
    });
  }

  

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progresso = _segundos / ((int.tryParse(_timeController.text) ?? 1) * 60); // Converter minutos para segundos

    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro/Temporizador'),
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
              height: 150,
              width: 150,
            ),
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tempo (minutos)'),
            ),
            SizedBox(height: 20),
            Text(
              '${(_segundos ~/ 60).toString().padLeft(2, '0')}:${(_segundos % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _toggleTimer,
                  child: _ativo ? Text('Pausar') : Text('Iniciar'),
                ),
                SizedBox(width: 20),
              
              ],
            ),
          ],
        ),
      ),
    );
  }
}