import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas/controle_tarefa.dart';

import 'modelo_tarefa.dart';
import 'controle_tarefa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Controle_tarefa(),
      child: MaterialApp(
        title: 'Task App',
        home: telaTarefas(),
      ),
    );
  }
}

class telaTarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Tarefas'),
        backgroundColor: Colors.blue,
      ),
      body: listaTarefas(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirJanelaCadastro(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _abrirJanelaCadastro(BuildContext context) {
    TextEditingController _tarefaControle = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: TextField(
            controller: _tarefaControle,
            decoration: InputDecoration(labelText: 'Titulo Tarefa'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<Controle_tarefa>(context, listen: false)
                    .adicionar(_tarefaControle.text);
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}

class listaTarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controle_tarefa>(
      // ignore: non_constant_identifier_names
      builder: (context, controle_tarefa, child) {
        return ListView.builder(
          itemCount: controle_tarefa.tarefas.length, //conta itens
         
          itemBuilder: (context, index) {
            Modelo_tarefa modelo_tarefa = controle_tarefa.tarefas[
                index]; // Correção: use "Modelo_tarefa" ao invés de "Modelo_tarefa"
            
            return ListTile(
              title: Text(modelo_tarefa.titulo),
              leading: Checkbox(
                value: modelo_tarefa.completa,
                onChanged: (value) {
                  Provider.of<Controle_tarefa>(context, listen: false)
                      .concluir(index);
                },
              ),
              
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<Controle_tarefa>(context, listen: false)
                      .remover(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
