import 'package:flutter/material.dart';

class Tela1 extends StatefulWidget {
  @override
  calcularCombustivelEstado createState() => calcularCombustivelEstado();
}

class calcularCombustivelEstado extends State<Tela1> {
  //váriaveis do app
  TextEditingController entradaAlcool = TextEditingController();
  TextEditingController entradaGasolina = TextEditingController();
  IconData icone = Icons.help;
  Color corIcone = Colors.black;
  String resultado = '';

  //calculador combustivel
  void calcularOpcao() {
    //fazer conversão de texto para número
    double precoAlcool = double.tryParse(entradaAlcool.text) ?? 0.00;
    double precoGasolina = double.tryParse(entradaGasolina.text) ?? 0.00;

    //se o precoAlcool = 0 ou PrecoGasolina = 0
    if (precoAlcool == 0 || precoGasolina == 0) {
      setState(() {
        icone = Icons.error;
        corIcone = Colors.red;
        resultado = 'Por favor insira o preço do alcool ou gasolina!';
      });
    }
    //preço do alcool divido pelo preço da gasolina
    double total = precoAlcool / precoGasolina;
    //abastece com o alcool
    if (total < 0.7) {
      setState(() {
        icone = Icons.local_drink;
        corIcone = Colors.green;
        resultado = "Abasteça com Álcool!";
      });
    } else if (total > 0.7) {
      setState(() {
        icone = Icons.local_gas_station;
        corIcone = Colors.blue;
        resultado = "Abasteça com Gasolina";
      });
    } else {
      setState(() {
        icone = Icons.autorenew_sharp;
        corIcone = Colors.deepOrangeAccent;
        resultado = "Qualquer um!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 23, 68),
      appBar: AppBar(
        title: Text(
          'Álcool ou gasolina',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: entradaAlcool,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço do Álcool'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: entradaGasolina,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço da Gasolina'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularOpcao,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Icon(icone, size: 100, color: corIcone),
            SizedBox(height: 10),
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
