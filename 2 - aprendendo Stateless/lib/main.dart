import 'dart:math';

import 'package:aprendendo/PaginaInicial.dart';
import 'package:flutter/material.dart';

//a função principal que starta o aplicativo
void main() {
  runApp(const Aplicativo());
}

//não muda nada, é sincrono, só carrega uma vez - não dinâmico
//a classe extende de um widget sem estado
class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  //build - método que sempre reconstroi a tela
  @override
  Widget build(BuildContext context) {
    //raiz do app = personaliza temas e rotas
    return MaterialApp(
      //adicionando tela branca
      theme: ThemeData.dark(),
      home: Scaffold(
        //titulo
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Flutter é divertido!'),
        ),

        //-----------------------------body Centralizando tudo ----------------
        //     ),

        body: Center(
          //-----------------------------body lidando com quadrado ----------------
          child: Column(
            mainAxisSize: MainAxisSize.min, // Mantém os widgets centralizados
            children: [
              const SizedBox(
                child: Text('Testando 1 2 3, Conteúdo do App'),
                height: 100,
                width: 100,
              ),

              //---------- trabalhando com container
              Container(
                child: const Text('Hi Mom 🐣'),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                color: Colors.lightBlue,
                height: 100,
                width: 100,
              ),

              //------------body colocando em linha e centralizadno ----------------
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //center
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.leaderboard),
                  Icon(Icons.person),
                ],
              ),
              ////----------------alinhando um item dentro do outro ----------------
              // body: Stack(
              //   children: [
              //     Container(
              //       color: Colors.red,
              //       width: 100,
              //       height: 100,
              //     ),
              //     Positioned(
              //       child: Icon(Icons.verified),
              //       top: 50,
              //       left: 50,
              //     )
              //   ],
              // ),
            ],
          ),
        ),

        //----------------------------alternar cores -----------------------
        // body: ListView.builder(
        //   itemBuilder: (_, index){
        //     return Container(

        //       width: 500,
        //       height: 500,

        //     );
        //   }
        // ),

        //-------icone flutuante mágico ----------------------------------
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),

        //--barra de navegação em baixo---------------------------------------
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ]),

        //--barra lateral---------------------------------------
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Texto do Cabeçalho',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.home),
                title: Text('Página Inicial'),
                onTap: () {
                  Navigator.pop(context); // Fecha o Drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaInicial()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Perfil'),
                onTap: () {
                  // Lógica para o perfil
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configurações'),
                onTap: () {
                  // Lógica para as configurações
                },
              ),
              // Adicione mais ListTile conforme necessário
            ],
          ),
        ),
      ),
    );
  }
}
