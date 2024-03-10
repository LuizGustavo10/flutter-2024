import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (cm)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado do IMC: ${bmiResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmiResult = bmi;
      });
    } else {
      // Trate o caso em que a altura ou o peso são inválidos
      // Por exemplo, exibindo uma mensagem de erro.
      // Neste exemplo, simplesmente definimos o resultado do IMC como 0.0.
      setState(() {
        bmiResult = 0.0;
      });
    }
  }
}