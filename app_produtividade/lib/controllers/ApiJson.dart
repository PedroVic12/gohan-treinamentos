import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:get/get.dart';

class ApiJsonController extends GetxController {
  List dados = [];

  Future<List<Map<String, dynamic>>> lerArquivoJSon(String jsonPath) async {
    try {
      final String jsonText = await rootBundle.loadString(jsonPath);
      final List<dynamic> jsonData = json.decode(jsonText);
      return jsonData.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Erro ao carregar JSON: $e");
      return [];
    }
  }

  Future<void> lerJsonFile(_caminho_json) async {
    final String response = await rootBundle.loadString(_caminho_json);
    final data = await json.decode(response);
    dados = data['itens'];
    print("Numero de itens ${dados.length}}");
    return data;
  }
}
