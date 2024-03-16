import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Álcool ou Gasolina',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelCalculator(),
    );
  }
}

class FuelCalculator extends StatefulWidget {
  @override
  _FuelCalculatorState createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  TextEditingController _controllerAlcohol = TextEditingController();
  TextEditingController _controllerGasoline = TextEditingController();
  IconData _resultIcon = Icons.help;
  Color _iconColor = Colors.black;
  String _resultText = '';

  void _calculateBestOption() {
    double alcoholPrice = double.tryParse(_controllerAlcohol.text) ?? 0.0;
    double gasolinePrice = double.tryParse(_controllerGasoline.text) ?? 0.0;

    if (alcoholPrice == 0 || gasolinePrice == 0) {
      setState(() {
        _resultIcon = Icons.error;
        _iconColor = Colors.red;
        _resultText = 'Por favor, insira os preços do álcool e da gasolina.';
      });
      return;
    }

    double efficiencyRatio = alcoholPrice / gasolinePrice;

    if (efficiencyRatio < 0.7) {
      setState(() {
        _resultIcon = Icons.local_drink;
        _iconColor = Colors.green;
        _resultText = 'Abasteça com Álcool!';
      });
    } else {
      setState(() {
        _resultIcon = Icons.local_gas_station;
        _iconColor = Colors.blue;
        _resultText = 'Abasteça com Gasolina!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Álcool ou Gasolina'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerAlcohol,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço do Álcool'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controllerGasoline,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço da Gasolina'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBestOption,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Icon(
              _resultIcon,
              size: 100,
              color: _iconColor,
            ),
            SizedBox(height: 10),
            Text(
              _resultText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}