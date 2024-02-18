import 'package:flutter/material.dart';
import 'modelo_tarefa.dart';

class Controle_tarefa extends ChangeNotifier {
  List<Modelo_tarefa> tarefas = [];

  void adicionar(String titulo) {
    tarefas.add(Modelo_tarefa(titulo: titulo));
    notifyListeners();
  }

  void concluir(int index) {
    tarefas[index].completa = !tarefas[index].completa;
    notifyListeners();
  }

  void remover(int index) {
    tarefas.removeAt(index);
    notifyListeners();
  }
}