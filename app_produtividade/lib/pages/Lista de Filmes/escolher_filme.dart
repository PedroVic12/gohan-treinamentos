import 'dart:async';

import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. RandomFilmButton
class RandomFilmButton extends StatelessWidget {
  final FilmesController controller;

  RandomFilmButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        for (int i = 3; i >= 1; i--) {
          controller.currentDisplay.value = i.toString();
          await Future.delayed(Duration(seconds: 1));
        }
        controller.selectRandomFilm();
      },
      child: Text('Escolher Filme Aleatório'),
    );
  }
}

// 2. FilmDisplay
class FilmDisplay extends StatelessWidget {
  final FilmesController controller;

  FilmDisplay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              controller.currentDisplay.value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
