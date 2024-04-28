import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Controlador Arduino'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  enviarComando('ligar');
                },
                child: Text('Ligar'),
              ),
              ElevatedButton(
                onPressed: () {
                  enviarComando('desligar');
                },
                child: Text('Desligar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> enviarComando(String comando) async {
    final url = 'http://endereco-do-seu-servidor-fastapi/comando';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'acao': comando.toUpperCase()});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Comando $comando enviado com sucesso');
    } else {
      print('Falha ao enviar comando $comando');
    }
  }
}
