import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesModel.dart';

class MeuHobbyController extends GetxController {
  RxList<MeuHobby> meusHobbies = <MeuHobby>[].obs;
  final LocalStorage storage = LocalStorage('hobbies_storage');

  // Lista de contadores, um para cada hobby
  List<int> contadores = [];

  @override
  void onInit() {
    super.onInit();
    loadMeusHobbiesWithDelay();
  }

  Future<void> loadMeusHobbiesWithDelay() async {
    await Future.delayed(Duration(seconds: 1));

    final String jsonData = await rootBundle.loadString(
        '/home/pedrov/Documentos/GitHub/gohan-treinamentos/app_produtividade/lib/assets/database.json');
    final List<dynamic> jsonList = json.decode(jsonData);
    meusHobbies
        .assignAll(jsonList.map((json) => MeuHobby.fromJson(json)).toList());

    // Inicialize a lista de contadores com zeros
    contadores = List<int>.filled(meusHobbies.length, 0);

    // Carregar contadores salvos no localStorage
    meusHobbies.forEach((hobby) {
      final count = storage.getItem('${hobby.title}_count');
      if (count != null) {
        hobby.contador = count;
      }
    });
  }

  void incrementarContador(MeuHobby hobby) async {
    hobby.increment();
    //await hiveBox.put('${hobby.title}_count', hobby.contador);
    update();
  }

  void resetCounts() {
    // Redefina todos os contadores para zero
    contadores = List<int>.filled(meusHobbies.length, 0);
    // Limpe os contadores salvos no localStorage
    meusHobbies.forEach((hobby) {
      storage.deleteItem('${hobby.title}_count');
    });
    update();
  }
}
