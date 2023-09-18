import 'dart:convert';
import 'package:app_produtividade/controllers/ApiJson.dart';
import 'package:app_produtividade/pages/5%20Hobbies/HobbiesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class HobbiesController extends GetxController {
  final LocalStorage storage = LocalStorage('hobbies_storage');
  RxList<Hobby> hobbies = RxList<Hobby>();
  ApiJsonController apiJsonController = ApiJsonController();
  bool isLoading = true;

  Future<void> loadHobbiesData() async {
    try {
      List<Map<String, dynamic>> jsonData =
          await apiJsonController.lerArquivoJSon('assets/database.json');

      if (jsonData.isNotEmpty) {
        hobbies.assignAll(jsonData.map((map) => Hobby.fromJson(map)).toList());
        isLoading =
            false; // Define isLoading como falso após o carregamento dos dados
        update(); // Notifique o Obx widget sobre as mudanças
      } else {
        // Trate o caso de dados vazios conforme necessário.
      }
    } catch (error) {
      print('Erro ao carregar dados do JSON: $error');
      isLoading = false;
      update(); // Certifique-se de chamar update() mesmo em caso de erro.
    }
  }

  int get totalHobbiesCount =>
      hobbies.fold(0, (previousValue, hobby) => previousValue + hobby.count);

  @override
  void onInit() {
    super.onInit();
    loadHobbiesData().then((_) {
      // Atualiza o estado após a tentativa de carga
      update();
    });
  }

  _loadCounts() async {
    await storage.ready;
    final data = storage.getItem('hobbies_data');
    if (data != null) {
      final List<Map<String, dynamic>> jsonData =
          List<Map<String, dynamic>>.from(data);
      hobbies.assignAll(
        jsonData.map((map) => Hobby.fromJson(map)).toList(),
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
    final jsonData = hobbies.map((hobby) => hobby.toJson()).toList();
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
