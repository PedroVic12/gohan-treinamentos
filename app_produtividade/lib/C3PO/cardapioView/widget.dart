// widgets
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../template/models.dart';

class CarrinhoPedidoController extends GetxController {
  // Para controle do estado de carregamento
  var isLoading = true.obs;

  // Usando RxMap para tornar o mapa de produtos reativo
  final SACOLA = <ProdutoModel, int>{}.obs;
  var preco = 0;
}

class TextLabel extends StatelessWidget {
  final String texto;
  final Color cor;
  final double size;
  const TextLabel(
      {super.key,
      required this.texto,
      this.cor = Colors.black,
      this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ));
  }
}

class RadioButtonGroup extends StatelessWidget {
  final List<String> niveis;
  final RxString nivelSelecionado;

  RadioButtonGroup({
    required this.niveis,
    required this.nivelSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        color: Colors.white70,
        child: Column(
          children: niveis
              .map((nivel) => RadioListTile(
                  dense: true,
                  title: TextLabel(texto: nivel),
                  value: nivel,
                  selected: nivelSelecionado.value == nivel,
                  groupValue: nivelSelecionado.value,
                  onChanged: (value) {
                    nivelSelecionado.value = value.toString();
                  }))
              .toList(),
        ),
      );
    });
  }
}
