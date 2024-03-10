// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './indicador_pagina.dart';
import './page_body.dart';

class PaginaInicial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaginaInicialState();
  }
}

class _PaginaInicialState extends State<PaginaInicial> {
  final _paginaInicialControle = PageController();
  int _pagina = 0;

  List _listaDePaginas = [
    pageBody(
        'https://assets-global.website-files.com/5f841209f4e71b2d70034471/6078b650748b8558d46ffb7f_Flutter%20app%20development.png',
        'Flutter da Google',
        'Na prática, o Flutter é uma ferramenta para desenvolver aplicativos em diferentes plataformas - Android e iOS - ao mesmo tempo com um único código. Logo, seus principais benefícios são a versatilidade, menor curva de aprendizado e agilidade. É extremamente vantajoso para as empresas, pois uma pessoa dev pode desenvolver aplicativos para sistemas operacionais diferentes, oposto ao modelo nativo, em que são necessários duas pessoas devs para cada plataforma.'),
        pageBody(
        'https://img-c.udemycdn.com/course/240x135/2345066_0cab_7.jpg',
        'Linguagem Dart',
        'O Dart é uma linguagem de programação fortemente tipada inicialmente criada pela Google em 2011. A missão inicial do Dart era substituir o JavaScript para desenvolvimento de scripts em páginas web. Porém, com a evolução da linguagem e com o passar dos anos, ela hoje pode ser considerada uma linguagem multi-paradigma, embora a linguagem apresente fortes estruturas típicas de linguagens orientadas a objeto.'),
        pageBody(
        'https://www.casadocodigo.com.br/cdn/shop/products/p_319fe74c-d444-43f0-8ea0-05f85622519c_large.jpg?v=1651084566',
        'O Guia de Dart',
        'Dart é uma linguagem de programação que está em ascensão. Criada e mantida pelo Google, vem ganhando destaque e apoio da comunidade nos últimos anos, com a popularidade crescente do Flutter. Hoje, ela é considerada multiplataforma, já que a partir dela e de seus frameworks conseguimos gerar aplicações nativas e de alta performance em server-side, na web, em desktop, nos dispositivos mobile e em IoT. Dart é orientada a objetos, com o benefício de ser tipada, possui conceitos de linguagem funcional, ainda em conjunto com um belo suporte a programação reativa. Tudo isso a tem tornado uma grande carta na manga no repertório de pessoas desenvolvedoras.'),
        pageBody(
        'https://img-c.udemycdn.com/course/240x135/2345066_0cab_7.jpg',
        'Flutter da Google',
        'Dart é uma linguagem de script voltada à web desenvolvida pela Google. Ela foi lançada na GOTO Conference 2011, que aconteceu de 10 a 11 de outubro de 2011 em Aarhus, na Dinamarca. O objetivo da linguagem Dart foi inicialmente a de substituir a JavaScript como a linguagem principal embutida nos navegadores.'),
    
  ];
  

  void _mudarPagina(bool proximaPagina) {
    if (_pagina < 2 && proximaPagina) {
      setState(() {
        _pagina++;
      });

      _paginaInicialControle.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else if (_pagina > 0 && !proximaPagina) {
      setState(() {
        _pagina--;
      });

      _paginaInicialControle.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página inicial do Aplicativo'),
        backgroundColor: Colors.blue,
      ),
      body: PageView.builder(
        controller: _paginaInicialControle,
        physics: NeverScrollableScrollPhysics(), //funciona só os botões
        itemBuilder: (BuildContext context, int index) {
          return _listaDePaginas[index];
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _mudarPagina(false),
            child: Text('Anterior'),
          ),
          indicadorPagina(_pagina == 0),
          indicadorPagina(_pagina == 1),
          indicadorPagina(_pagina == 2),
          TextButton(
            onPressed: () => _mudarPagina(true),
            child: Text('Próximo'),
          ),
        ],
      ),
    );
  }
}
