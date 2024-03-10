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
  int _seconds = 0;
  bool _isActive = false;
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timeController.text = "60"; // Valor padrão inicial
  }

  void _updateTimer(Timer timer) {
    if (_isActive && _seconds > 0) {
      setState(() {
        _seconds -= 1;
      });
    } else {
      _toggleTimer(); // Pausar quando o tempo chegar a zero
    }
  }

  void _toggleTimer() {
    setState(() {
      _isActive = !_isActive;
      if (_isActive) {
        _seconds = int.tryParse(_timeController.text) ?? 0;
        _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
      } else {
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _isActive = false;
      _seconds = int.tryParse(_timeController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = _seconds / (int.tryParse(_timeController.text) ?? 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro/Temporizador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tempo (segundos)'),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progressValue.isNaN ? 0.0 : progressValue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _toggleTimer,
                  child: _isActive ? Text('Pausar') : Text('Iniciar'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}