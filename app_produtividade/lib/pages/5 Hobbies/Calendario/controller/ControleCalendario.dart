import 'package:app_produtividade/controllers/ApiService.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/Evento.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';
import 'package:universal_html/html.dart'
    as html; // Importe o pacote universal_html

class EventoService {
  final String localStorageKey = 'eventos';
  List<Evento> eventos = [];

  EventoService() {
    _loadFromLocalStorage();
  }

  void _loadFromLocalStorage() {
    final jsonData = html.window.localStorage[localStorageKey];
    if (jsonData != null) {
      final List<dynamic> jsonList = jsonDecode(jsonData);
      eventos = jsonList.map((e) => Evento.fromJson(e)).toList();
    }
  }

  void saveToLocalStorage() {
    final jsonData = jsonEncode(eventos);
    html.window.localStorage[localStorageKey] = jsonData;
  }

  void adicionarEvento(Evento evento) {
    eventos.add(evento);
    saveToLocalStorage();
  }

  void removerEvento(Evento evento) {
    eventos.remove(evento);
    saveToLocalStorage();
  }
}

class FonteDadosReuniao extends CalendarDataSource {
  FonteDadosReuniao(List<Evento> fonte) {
    appointments = fonte;
  }
  @override
  DateTime getStartTime(int index) => appointments![index].inicio;
  @override
  DateTime getEndTime(int index) => appointments![index].fim;
  @override
  String getSubject(int index) => appointments![index].nomeEvento;
  @override
  Color getColor(int index) => appointments![index].corFundo;
  @override
  bool isAllDay(int index) => appointments![index].diaTodo;
}


class CalendarioController {
  final EventoService eventoService = EventoService();
  FonteDadosReuniao fonteDadosReuniao = FonteDadosReuniao([]);

  RxString prioridadeSelecionada = 'Trabalho'.obs;

  void atualizarPrioridade(String novaPrioridade) {
    prioridadeSelecionada.value = novaPrioridade;
  }

  CalendarioController() {
    fonteDadosReuniao.appointments = eventoService.eventos;
  }

  void adicionarReuniao(DateTime dataSelecionada, String nomeEvento) {
    final DateTime inicio = DateTime(
      dataSelecionada.year,
      dataSelecionada.month,
      dataSelecionada.day,
      9,
      0,
      0,
    );
    final DateTime fim = inicio.add(const Duration(hours: 2));
    final evento = Evento(nomeEvento, inicio, fim, Colors.blue, false);
    eventoService.adicionarEvento(evento);
  }

  List<Evento> obterReunioesDoDia(DateTime dia) {
    return eventoService.eventos
        .where((reuniao) =>
            reuniao.inicio.year == dia.year &&
            reuniao.inicio.month == dia.month &&
            reuniao.inicio.day == dia.day)
        .toList();
  }
}


