import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Desconto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiscountCalculatorScreen(),
    );
  }
}

class DiscountCalculatorScreen extends StatefulWidget {
  @override
  _DiscountCalculatorScreenState createState() => _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends State<DiscountCalculatorScreen> {
  TextEditingController _originalPriceController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  double _finalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Desconto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _originalPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço Original'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Desconto (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFinalPrice,
              child: Text('Calcular Preço Final'),
            ),
            SizedBox(height: 20),
            Text(
              'Preço Final: R\$ ${_finalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateFinalPrice() {
    double originalPrice = double.tryParse(_originalPriceController.text) ?? 0.0;
    double discountPercentage = double.tryParse(_discountController.text) ?? 0.0;

    if (originalPrice > 0 && discountPercentage >= 0 && discountPercentage <= 100) {
      double discountAmount = originalPrice * (discountPercentage / 100);
      double finalPrice = originalPrice - discountAmount;

      setState(() {
        _finalPrice = finalPrice;
      });
    } else {
      setState(() {
        _finalPrice = 0.0;
      });
    }
  }
}