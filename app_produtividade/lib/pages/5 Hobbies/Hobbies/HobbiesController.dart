import 'dart:convert';
import 'package:app_produtividade/controllers/ApiJson.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart'; // Importe a biblioteca

class MeuHobbyController extends GetxController {
  RxList<Map<String, dynamic>> meusHobbies = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMeusHobbies();
  }

  Future<void> loadMeusHobbies() async {
    final String jsonData =
        await rootBundle.loadString('assets/database.json');
    final List<dynamic> jsonList = json.decode(jsonData);

    meusHobbies.assignAll(jsonList.cast<Map<String, dynamic>>());
  }
}

class HobbiesController extends GetxController {
  // Setando parametros
  final LocalStorage storage = LocalStorage('hobbies_storage');
  final ApiJsonController apiJsonController = ApiJsonController();
  RxList<MeuHobby> hobbies = RxList<MeuHobby>();
  RxList<Hobby> todosHobbies = RxList<Hobby>();

  bool isLoading = true;

// Getters e setters
  int get totalHobbiesCount =>
      hobbies.fold(0, (previousValue, hobby) => previousValue + hobby.count);

  //!Funções de JSON
  @override
  void onInit() {
    super.onInit();
    loadHobbiesData();
  }

  Future<void> loadHobbiesData() async {
    try {
      final jsonData =
          await apiJsonController.lerArquivoJSon('assets/database.json');

      if (jsonData.isNotEmpty) {
        hobbies
            .assignAll(jsonData.map((map) => MeuHobby.fromJson(map)).toList());
        isLoading = false;
        update();
      } else {
        // Trate o caso de dados vazios conforme necessário.
      }
    } catch (error) {
      print('Erro ao carregar dados do JSON: $error');
      isLoading = false;
      update();
    }
  }

  // Função para salvar os dados em um arquivo JSON
  Future<void> saveDataToJson(List<Map<String, dynamic>> data) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = path.join(
        documentsDirectory.path, 'data.json'); // Caminho para o arquivo JSON
    final file = File(filePath);

    try {
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Erro ao salvar os dados em JSON: $e');
    }
  }

// Função para ler os dados de um arquivo JSON
  Future<List<Map<String, dynamic>>> readDataFromJson() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = path.join(
        documentsDirectory.path, 'data.json'); // Caminho para o arquivo JSON
    final file = File(filePath);

    try {
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List) {
          return jsonData.cast<Map<String, dynamic>>();
        }
      }
    } catch (e) {
      print('Erro ao ler os dados de JSON: $e');
    }

    return [];
  }

  Future<void> loadDataLocally() async {
    try {
      final jsonData = await readDataFromJson();
      if (jsonData.isNotEmpty) {
        hobbies
            .assignAll(jsonData.map((map) => MeuHobby.fromJson(map)).toList());
      }
    } catch (e) {
      print('Erro ao carregar os dados localmente: $e');
    }
  }

  //! Funções De Incremento
  _loadCounts() async {
    await storage.ready;
    final data = storage.getItem('hobbies_data');
    if (data != null) {
      final List<Map<String, dynamic>> jsonData =
          List<Map<String, dynamic>>.from(data);
      hobbies.assignAll(
        jsonData.map((map) => MeuHobby.fromJson(map)).toList(),
      );
    } else {
      // Se os dados ainda não existirem, você pode inicializá-los aqui.
      // Por exemplo:
      // hobbies.assignAll([
      //   Hobby(title: "Hobby 1", description: "Descrição 1"),
      //   Hobby(title: "Hobby 2", description: "Descrição 2"),
      //   // Adicione mais hobbies aqui...
      // ]);
    }
  }

  incrementHobby(int index) {
    hobbies[index].count++;
    _saveCounts();
  }

  _saveCounts() {
    final jsonData = hobbies.map((hobby) => todosHobbies.toJson()).toList();
    storage.setItem('hobbies_data', jsonData);
  }

  resetCounts() {
    for (var hobby in hobbies) {
      hobby.count = 0;
    }
    _saveCounts();
    update();
  }
}
