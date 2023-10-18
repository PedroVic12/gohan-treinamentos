import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Evento {
  String nomeEvento;
  DateTime inicio;
  DateTime fim;
  Color corFundo;
  bool diaTodo;

  Evento(this.nomeEvento, this.inicio, this.fim, this.corFundo, this.diaTodo);

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      json['nomeEvento'],
      DateTime.parse(json['inicio']),
      DateTime.parse(json['fim']),
      Color(int.parse(json['corFundo'])),
      json['diaTodo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeEvento': nomeEvento,
      'inicio': inicio.toIso8601String(),
      'fim': fim.toIso8601String(),
      'corFundo': corFundo.value.toString(),
      'diaTodo': diaTodo,
    };
  }
}

class EventoController {
  final List<Evento> eventos = [];
  final String eventosKey = 'eventos_key';

  Future<void> carregarEventos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      eventos.clear();
      for (final eventoJson in eventosJson) {
        final evento = Evento.fromJson(Map<String, dynamic>.from(eventoJson as Map));
        eventos.add(evento);
      }
    } catch (e) {
      // Lidar com erros ao carregar eventos, se necessário
      print('Erro ao carregar eventos: $e');
    }
  }

  Future<void> salvarEvento(Evento evento) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      eventosJson.add(evento.toJson() as String);

      await prefs.setStringList(eventosKey, eventosJson);
    } catch (e) {
      // Lidar com erros ao salvar eventos, se necessário
      print('Erro ao salvar evento: $e');
    }
  }

  Future<void> removerEvento(Evento evento) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      eventosJson.remove(evento.toJson());

      await prefs.setStringList(eventosKey, eventosJson);
    } catch (e) {
      // Lidar com erros ao remover eventos, se necessário
      print('Erro ao remover evento: $e');
    }
  }
}
