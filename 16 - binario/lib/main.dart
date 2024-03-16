import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Binária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BinaryCalculator(),
    );
  }
}

class BinaryCalculator extends StatefulWidget {
  @override
  _BinaryCalculatorState createState() => _BinaryCalculatorState();
}

class _BinaryCalculatorState extends State<BinaryCalculator> {
  TextEditingController _decimalController = TextEditingController();
  String _binaryResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Binária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _decimalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número Decimal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertToBinary,
              child: Text('Converter para Binário'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado Binário: $_binaryResult',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _convertToBinary() {
    String decimalStr = _decimalController.text.trim();
    int decimal = int.tryParse(decimalStr) ?? 0;
    setState(() {
      _binaryResult = decimal.toRadixString(2);
    });
  }
}