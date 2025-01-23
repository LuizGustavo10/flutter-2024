import 'package:flutter/material.dart';

class Tela3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => calcular();
}

class calcular extends State<Tela3> {
  TextEditingController preco = TextEditingController();
  TextEditingController desconto = TextEditingController();
  double precoFinal = 0.0;

  void efetuarDesconto() {
    double precoValor = double.tryParse(preco.text) ?? 0.0;
    double descontoValor = double.tryParse(desconto.text) ?? 0.0;

    //se o preço > 0 e desconto > 0 e desconto <= 100
    if (precoValor > 0 && descontoValor > 0 && descontoValor <= 100) {
      double qtdDesc = precoValor * (descontoValor / 100);

      setState(() {
        precoFinal = precoValor - qtdDesc;
      });
    } else {
      setState(() {
        precoFinal = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          'Calculadora de Desconto',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // ignore: prefer_const_constructors
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: preco,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Preço Original (%)'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: desconto,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Desconto (%)')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: efetuarDesconto, child: Text('Calcular')),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Preço Final: $precoFinal',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
