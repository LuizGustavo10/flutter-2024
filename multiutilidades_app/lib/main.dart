import 'package:flutter/material.dart';
import 'package:multapp/Tela1.dart';
import 'package:multapp/Tela2.dart';
import 'package:multapp/Tela3.dart';
import 'package:multapp/Tela4.dart';
import 'package:multapp/Tela5.dart';
import 'package:multapp/Tela6.dart';

void main() {
  runApp(Aplicativo());
}

class Aplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiutilidades App',
      theme: ThemeData.dark(),
      home: Menu(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/tela1': (context) => Tela1(),
        '/tela2': (context) => Tela2(),
        '/tela3': (context) => Tela3(),
        '/tela4': (context) => Tela4(),
        '/tela5': (context) => Tela5(),
        '/tela6': (context) => Tela6(),
      },
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 23, 68),
      appBar: AppBar(
        title: Text(
          'Menu Principal',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: const <Widget>[
            botao(
                texto: 'Melhor Combustível',
                rota: '/tela1',
                icone: Icons.local_gas_station,
                cor: Colors.red),
            botao(
                texto: 'IMC',
                rota: '/tela2',
                icone: Icons.accessibility,
                cor: Colors.orange),
            botao(
                texto: 'Desconto',
                rota: '/tela3',
                icone: Icons.money_off_csred_rounded,
                cor: Colors.yellow),
            botao(
                texto: 'Gorjeta',
                rota: '/tela4',
                icone: Icons.monetization_on,
                cor: Colors.green),
            botao(
                texto: 'Gasto Combustível',
                rota: '/tela5',
                icone: Icons.speed,
                cor: Colors.blue),
            botao(
                texto: 'Pomodoro',
                rota: '/tela6',
                icone: Icons.timer,
                cor: Colors.pink),
          ],
        ),
      ),
    );
  }
}

class botao extends StatelessWidget {
  final String texto;
  final String rota;
  final IconData icone;
  final Color cor;

  const botao(
      {Key? key,
      required this.texto,
      required this.rota,
      required this.icone,
      required this.cor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 48, 61, 99),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
        onPressed: () {
          Navigator.pushNamed(context, rota);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: cor, size: 70),
            SizedBox(height: 8),
            Text(
              texto,
              style: TextStyle(color: cor, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
