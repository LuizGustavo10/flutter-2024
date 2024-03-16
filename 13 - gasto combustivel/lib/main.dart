import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Combustível',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelCalculatorScreen(),
    );
  }
}

class FuelCalculatorScreen extends StatefulWidget {
  @override
  _FuelCalculatorScreenState createState() => _FuelCalculatorScreenState();
}

class _FuelCalculatorScreenState extends State<FuelCalculatorScreen> {
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _consumptionController = TextEditingController();
  TextEditingController _fuelPriceController = TextEditingController();
  double _fuelAmount = 0.0;
  double _totalCost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Combustível'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Distância (km)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _consumptionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Consumo Médio (km/l)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _fuelPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço do Combustível (R\$ por litro)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFuelAmount,
              child: Text('Calcular Quantidade de Combustível'),
            ),
            SizedBox(height: 20),
            Text(
              'Quantidade de Combustível: ${_fuelAmount.toStringAsFixed(2)} litros',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Custo Total: R\$ ${_totalCost.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateFuelAmount() {
    double distance = double.tryParse(_distanceController.text) ?? 0.0;
    double consumption = double.tryParse(_consumptionController.text) ?? 0.0;
    double fuelPrice = double.tryParse(_fuelPriceController.text) ?? 0.0;

    if (distance > 0 && consumption > 0 && fuelPrice > 0) {
      double fuelAmount = distance / consumption;
      double totalCost = fuelAmount * fuelPrice;
      setState(() {
        _fuelAmount = fuelAmount;
        _totalCost = totalCost;
      });
    } else {
      setState(() {
        _fuelAmount = 0.0;
        _totalCost = 0.0;
      });
    }
  }
}