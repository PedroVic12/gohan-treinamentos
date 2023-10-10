import 'package:flutter/material.dart';

class Evento {
  Evento(this.nomeEvento, this.inicio, this.fim, this.corFundo, this.diaTodo);

  String nomeEvento;
  DateTime inicio;
  DateTime fim;
  Color corFundo;
  bool diaTodo;
}
