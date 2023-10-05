import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GohanFastApi {
  final String baseUrl = "http://localhost:8000"; // URL base do FastAPI

  // Método POST para enviar dados para o servidor
  Future<void> postData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/events"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception("Falha ao enviar dados para o servidor");
    }
  }

  // Método GET para buscar dados do servidor
  Future<List<Map<String, dynamic>>> getData() async {
    final response = await http.get(Uri.parse("$baseUrl/events"));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao buscar dados do servidor");
    }
  }

  // Método DELETE para remover um evento do servidor pelo ID
  Future<void> deleteData(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/events/$id"));

    if (response.statusCode != 200) {
      throw Exception("Falha ao remover o evento");
    }
  }

  // Método para gerar um ListTile a partir dos dados obtidos
  Widget buildEventTile(Map<String, dynamic> event) {
    return ListTile(
      title: Text(event["nomeDoEvento"]),
      subtitle: Text(event["categoria"]),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await deleteData(event["id"]); // Chamada ao método DELETE
          // Atualize sua lista de eventos após a exclusão
        },
      ),
    );
  }
}
