import 'dart:io';
import 'dart:convert';

class ServidorDart {
  HttpServer? _server;
  List<Evento> eventos = [];

  Future<void> iniciar() async {
    _server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      7000,
    );
    print('Listening on localhost:${_server?.port}');

    await for (HttpRequest request in _server!) {
      final path = request.uri.path;
      final method = request.method;

      if (path == '/evento' && method == 'POST') {
        await _handlePost(request);
      } else if (path == '/eventos' && method == 'GET') {
        _handleGet(request);
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found')
          ..close();
      }
    }
  }

  Future<void> _handlePost(HttpRequest request) async {
    final content = await utf8.decoder.bind(request).join();
    final data = jsonDecode(content) as Map<String, dynamic>;

    final evento = Evento(
      nome: data['nome'],
      inicio: DateTime.parse(data['inicio']),
      fim: DateTime.parse(data['fim']),
    );
    eventos.add(evento);

    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode({'message': 'Evento adicionado'}))
      ..close();
  }

  void _handleGet(HttpRequest request) {
    final response = eventos.map((e) => e.toJson()).toList();
    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode(response))
      ..close();
  }
}

class Evento {
  String nome;
  DateTime inicio;
  DateTime fim;

  Evento({
    required this.nome,
    required this.inicio,
    required this.fim,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'inicio': inicio.toIso8601String(),
        'fim': fim.toIso8601String(),
      };
}

Future<void> main() async {
  final servidor = ServidorDart();
  await servidor.iniciar();
}
