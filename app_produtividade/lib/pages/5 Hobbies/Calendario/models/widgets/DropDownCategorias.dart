import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/ControleCalendario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/Custom/CustomText.dart';

class DropDownCategoria extends StatefulWidget {
  DropDownCategoria({Key? key}) : super(key: key);

  @override
  State<DropDownCategoria> createState() => _DropDownCategoriaState();
}

class _DropDownCategoriaState extends State<DropDownCategoria> {
  var items = ['Alta', 'Médio', 'Baixo'];
  String categoriaSelecionada = 'Baixo'; // Defina o valor inicial aqui

  final calendario = Get.put(CalendarioController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 6.0,
            spreadRadius: 1.0,
            color: Colors.black26,
          ),
        ],
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.black,
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white,
            ),
          ),
        ),
        underline: Container(),
        value: categoriaSelecionada, // Defina o valor inicial aqui
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item, // Use o valor do item atual
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: item),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            categoriaSelecionada = newValue!;
            calendario.atualizarPrioridade(categoriaSelecionada);
            print('Prioridade selecionada: $categoriaSelecionada');
          });
        },
      ),
    );
  }
}
