import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> adicionarEvento(
      String nome, DateTime inicio, DateTime fim) async {
    final url = Uri.parse('$baseUrl/evento');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'inicio': inicio.toIso8601String(),
        'fim': fim.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar evento');
    }
  }

  Future<List<EventoCalendario>> obterEventos() async {
    final url = Uri.parse('$baseUrl/eventos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((evento) => EventoCalendario.fromJson(evento)).toList();
    } else {
      throw Exception('Falha ao obter eventos');
    }
  }
}

class EventoCalendario {
  String nome;
  DateTime inicio;
  DateTime fim;

  EventoCalendario({
    required this.nome,
    required this.inicio,
    required this.fim,
  });

  factory EventoCalendario.fromJson(Map<String, dynamic> json) {
    return EventoCalendario(
      nome: json['nome'],
      inicio: DateTime.parse(json['inicio']),
      fim: DateTime.parse(json['fim']),
    );
  }
}
