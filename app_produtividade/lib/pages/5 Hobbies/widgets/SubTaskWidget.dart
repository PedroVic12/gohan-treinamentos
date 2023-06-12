import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubTaskWidget extends StatelessWidget {
  final String title;
  final bool isChecked;

  SubTaskWidget({required this.title, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: (value) {
            // Atualiza o estado do checkbox quando for alterado
            // Você pode usar um Controller GetX para gerenciar o estado
            // do checkbox e armazenar os dados em um modelo ou controlador.
            // Por exemplo: controller.updateTaskChecked(index);
          },
        ),
        title: Text(title),
      ),
    );
  }
}
