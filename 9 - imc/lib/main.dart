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
  String bmiDescription = '';
  String bmiImagePath = '';

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
            SizedBox(height: 10),
            Text(
              'Classificação: $bmiDescription',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            if (bmiImagePath.isNotEmpty)
              Image.asset(
                bmiImagePath,
                width: 100,
                height: 100,
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
        bmiDescription = getBMIDescription(bmi);
        bmiImagePath = getBMIImagePath(bmi);
      });
    } else {
      // Trate o caso em que a altura ou o peso são inválidos
      // Por exemplo, exibindo uma mensagem de erro.
      // Neste exemplo, simplesmente definimos o resultado do IMC como 0.0.
      setState(() {
        bmiResult = 0.0;
        bmiDescription = '';
        bmiImagePath = '';
      });
    }
  }

  String getBMIDescription(double bmi) {
    if (bmi < 18.5) {
      return 'Abaixo do peso';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Peso normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Sobrepeso';
    } else if (bmi >= 30 && bmi < 34.9) {
      return 'Obesidade grau I';
    } else if (bmi >= 35 && bmi < 39.9) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }

  String getBMIImagePath(double bmi) {
    if (bmi < 18.5) {
      return 'assets/images/underweight.png';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'assets/images/normalweight.png';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'assets/images/overweight.png';
    } else if (bmi >= 30 && bmi < 34.9) {
      return 'assets/images/obesity1.png';
    } else if (bmi >= 35 && bmi < 39.9) {
      return 'assets/images/obesity2.png';
    } else {
      return 'assets/images/obesity3.png';
    }
  }
}