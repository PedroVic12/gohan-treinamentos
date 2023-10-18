import 'package:app_produtividade/controllers/ApiService.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/Evento.dart';
import 'package:flutter/material.dart';

class ControladorCalendario {
  List<Evento> reunioes = <Evento>[];

  void adicionarReuniao(DateTime dataSelecionada, String nomeEvento) {
    final DateTime inicio = DateTime(dataSelecionada.year,
        dataSelecionada.month, dataSelecionada.day, 9, 0, 0);
    final DateTime fim = inicio.add(const Duration(hours: 2));
    reunioes.add(Evento(nomeEvento, inicio, fim, Colors.blue, false));
  }

  List<Evento> obterReunioesDoDia(DateTime dia) {
    return reunioes
        .where((reuniao) =>
            reuniao.inicio.year == dia.year &&
            reuniao.inicio.month == dia.month &&
            reuniao.inicio.day == dia.day)
        .toList();
  }
}
