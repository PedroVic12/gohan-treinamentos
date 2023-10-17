import 'package:flutter/material.dart';

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
