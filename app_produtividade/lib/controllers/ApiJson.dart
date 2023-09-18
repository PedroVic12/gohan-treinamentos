import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ApiJsonController {
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
}
