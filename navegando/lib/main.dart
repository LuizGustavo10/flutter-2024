import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
         backgroundColor: Colors.yellow,
        ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://miro.medium.com/v2/resize:fit:1358/1*6JxdGU2WIzHSUEGBx4QeAQ.jpeg', width: 300, height: 300,), // Certifique-se de ter uma imagem em assets/
            Text('Bem-vindo à Página Inicial'),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                );
              },
              child: Text('Ir para a Página 2'),
            
            ),
          ],
        ),
      ),
    );
  }
}



class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página 2'),
        backgroundColor: Colors.blue,
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://miro.medium.com/v2/resize:fit:1358/1*6JxdGU2WIzHSUEGBx4QeAQ.jpeg', width: 300, height: 300,), // Certifique-se de ter uma imagem em assets/
            Text('Esta é a Página 2'),
            SizedBox(height: 20),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page3()),
                );
              },
              child: Text('Ir para a Página 3'),
            ),
          ],
        ),
      ),
    );
  }
}


class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página 3'),
         backgroundColor: Colors.green,


          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Opção 1'),
                    value: 'opcao1',
                  ),
                  PopupMenuItem(
                    child: Text('Opção 2'),
                    value: 'opcao2',
                  ),
                  // Adicione mais opções conforme necessário
                ];
              },
              onSelected: (value) {
                // Ação ao selecionar uma opção do menu pop-up
              },
            ),
          ],
         
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://miro.medium.com/v2/resize:fit:1358/1*6JxdGU2WIzHSUEGBx4QeAQ.jpeg', width: 300, height: 300,), // Certifique-se de ter uma imagem em assets/
            Text('Esta é a Página 3'),
            SizedBox(height: 20),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('Voltar para Página Inicial!'),
            ),
          ],
        ),
      ),
    );  
  }
}
