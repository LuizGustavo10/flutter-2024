import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Gorjeta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double billAmount = 0.0;
  int tipPercentage = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Gorjeta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor da Conta'),
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Porcentagem de Gorjeta: $tipPercentage%',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Slider(
                  value: tipPercentage.toDouble(),
                  min: 0,
                  max: 30,
                  divisions: 6,
                  onChanged: (double value) {
                    setState(() {
                      tipPercentage = value.round();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateTotal();
              },
              child: Text('Calcular Gorjeta'),
            ),
            SizedBox(height: 20),
            Text(
              'Total da Conta: \$${calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotal() {
    double tipAmount = (billAmount * tipPercentage) / 100;
    double totalAmount = billAmount + tipAmount;
    return totalAmount;
  }
}