import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotaoNavegacao extends StatelessWidget {
  BotaoNavegacao({super.key, required this.pagina, required this.titlePagina});

  final Function pagina;
  final String titlePagina;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            Get.to(pagina);
          },
          child: Text(titlePagina)),
    );
  }
}
