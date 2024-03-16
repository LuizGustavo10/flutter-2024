import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int _seconds = 1500; // 25 minutes
  bool _isActive = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _isActive = false;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (_seconds ~/ 60).toString().padLeft(2, '0');
    String secondsStr = (_seconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$minutesStr:$secondsStr',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _isActive
                    ? ElevatedButton(
                        onPressed: _resetTimer,
                        child: Text('Reiniciar'),
                      )
                    : ElevatedButton(
                        onPressed: _startTimer,
                        child: Text('Iniciar'),
                      ),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Parar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      _isActive = true;
    });
  }

  void _stopTimer() {
    setState(() {
      _isActive = false;
      _seconds = 1500; // Reset to 25 minutes
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 1500; // Reset to 25 minutes
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}