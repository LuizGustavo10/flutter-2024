import 'package:flutter/material.dart';

class Tela5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => calcular();
}

class calcular extends State<Tela5> {
  TextEditingController distancia = TextEditingController();
  TextEditingController consumo = TextEditingController();
  TextEditingController preco = TextEditingController();
  double qtdCombustivel = 0.0;
  double total = 0.0;

  void calcularCombustivel() {
    //fazendo conversões de texto para double(decimal(número com vírgula))
    double distanciaValor = double.tryParse(distancia.text) ?? 0.0;
    double consumoValor = double.tryParse(consumo.text) ?? 0.0;
    double precoValor = double.tryParse(preco.text) ?? 0.0;

    //se distância, consumo e preco for maior que zero
    if (distanciaValor > 0 && consumoValor > 0 && precoValor > 0) {
      setState(() {
        qtdCombustivel = distanciaValor / consumoValor;
        total = qtdCombustivel * precoValor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de Combustível',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: distancia,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Distância (KM)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: consumo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Consumo (Km/L)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: preco,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularCombustivel,
              child: Text('Calcular'),
            ),
            SizedBox(height: 60),
            Text(
              'Quantidade de Combustível: ${qtdCombustivel.toStringAsFixed(2)} Litros',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Custo Total: R\$ ${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
