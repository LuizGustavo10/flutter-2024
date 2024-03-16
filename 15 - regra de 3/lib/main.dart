import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regra de Três',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RuleOfThreeCalculator(),
    );
  }
}

class RuleOfThreeCalculator extends StatefulWidget {
  @override
  _RuleOfThreeCalculatorState createState() => _RuleOfThreeCalculatorState();
}

class _RuleOfThreeCalculatorState extends State<RuleOfThreeCalculator> {
  TextEditingController _value1Controller = TextEditingController();
  TextEditingController _value2Controller = TextEditingController();
  TextEditingController _value3Controller = TextEditingController();
  double? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Regra de Três'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _value1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor 1'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _value2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor 2'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _value3Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateRuleOfThree,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            _result != null
                ? Text(
                    'Resultado: $_result',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _calculateRuleOfThree() {
    double value1 = double.tryParse(_value1Controller.text) ?? 0.0;
    double value2 = double.tryParse(_value2Controller.text) ?? 0.0;
    double value3 = double.tryParse(_value3Controller.text) ?? 0.0;

    if (value1 != 0 && value2 != 0) {
      setState(() {
        _result = (value3 * value2) / value1;
      });
    } else {
      setState(() {
        _result = null;
      });
    }
  }
}