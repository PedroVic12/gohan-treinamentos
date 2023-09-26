import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotaoNavegacao extends StatelessWidget {
  BotaoNavegacao({
    super.key,
    required this.pagina,
    required this.titlePagina,
  });

  final Widget pagina;
  final String titlePagina;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => pagina); // Navegar para a página com o controlador
          },
          child: Text(titlePagina),
        ),
      ),
    );
  }
}
