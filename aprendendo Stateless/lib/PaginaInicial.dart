import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const PaginaInicial());
}

//não muda nada, é sincrono, só carrega uma vez - não dinâmico
//a classe extende de um widget sem estado
class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  //build - método que sempre reconstroi a tela
  @override
  Widget build(BuildContext context) {
    //raiz do app = personaliza temas e rotas
    return MaterialApp(
      //adicionando tela branca
      home: Scaffold(
        //titulo
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Inicio!'),
        ),

        //-----------------------------body lidando com quadrado ----------------
        // body: Container(
        //       child: const Text('Hi Mom 🐣'),
        //       margin: const EdgeInsets.all(100),
        //       padding: const EdgeInsets.all(10),
        //       color: Colors.lightBlue,
        //       height: 100,
        //       width: 100,

        //-----------------------------body Centralizando tudo ----------------
        //     )
        body: const Center(
          child: SizedBox(
            child: const Text('Inicio'),
            height: 100,
            width: 100,
          ),
        ),

        //------------body colocando em linha e centralizadno ----------------
        // body: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly, //center
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: const [

        //     // Expanded(
        //     //   flex: 4,
        //     //   child: Icon(Icons.backpack),
        //     // ),
        //     Icon(Icons.leaderboard),
        //     Icon(Icons.person),
        //   ],
        // ),
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
