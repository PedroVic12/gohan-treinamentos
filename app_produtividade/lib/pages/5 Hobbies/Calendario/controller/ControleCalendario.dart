import 'package:app_produtividade/controllers/ApiService.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/models/Evento.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';
import 'package:universal_html/html.dart'
    as html; // Importe o pacote universal_html

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

class BlurGlassCardWidget extends StatelessWidget {
  final List<Evento> eventos;

  const BlurGlassCardWidget({Key? key, required this.eventos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GlassContainer(
        height: 200,
        width: 350,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.40),
            Colors.white.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.purpleAccent.withOpacity(0.05),
            Colors.purpleAccent.withOpacity(0.60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.39, 0.40, 1.0],
        ),
        blur: 32,
        borderRadius: BorderRadius.circular(24.0),
        borderWidth: 1.0,
        elevation: 3.0,
        isFrostedGlass: true,
        shadowColor: Colors.purple.withOpacity(0.20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eventos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    final evento = eventos[index];
                    return ListTile(
                      title: Text(evento.nomeEvento),
                      subtitle: Text(
                          'Data: ${evento.inicio.day}/${evento.inicio.month}/${evento.inicio.year}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarioController {
  final String localStorageKey = 'eventos';
  List<Evento> reunioes = <Evento>[];

  RxString prioridadeSelecionada = 'Trabalho'.obs;

  void atualizarPrioridade(String novaPrioridade) {
    prioridadeSelecionada.value = novaPrioridade;
  }

  ControladorCalendario() {
    // Carregue os eventos do localStorage quando o controlador for criado
    if (kIsWeb) {
      _loadFromLocalStorageWeb(); // Use a função específica para web
    } else {
      _loadFromLocalStorage(); // Use a função original para outros ambientes
    }
  }

  void _saveToLocalStorage() {
    final jsonData = jsonEncode(reunioes);
    if (kIsWeb) {
      html.window.localStorage[localStorageKey] =
          jsonData; // Acesse localStorage via universal_html
    } else {
      // Use outra estratégia para salvar em outros ambientes (por exemplo, shared_preferences)
    }
  }

  void _loadFromLocalStorage() {
    final jsonData = html.window.localStorage[
        localStorageKey]; // Acesse localStorage via universal_html
    if (jsonData != null) {
      final List<dynamic> jsonList = jsonDecode(jsonData);
      reunioes = jsonList.map((e) => Evento.fromJson(e)).toList();
    }
  }

  // Função específica para web
  void _loadFromLocalStorageWeb() {
    final jsonData = html.window.localStorage[localStorageKey];
    if (jsonData != null) {
      final List<dynamic> jsonList = jsonDecode(jsonData);
      reunioes = jsonList.map((e) => Evento.fromJson(e)).toList();
    }
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
    reunioes.add(evento);

    // Salve os eventos no localStorage após adicionar um novo
    _saveToLocalStorage(); // Certifique-se de que esta linha esteja presente
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
