import 'package:app_produtividade/pages/PlanosGENAI/PDF%20data%20Analysis/cadastro_simples.dart';
import 'package:app_produtividade/pages/TodoList%20Interativa/todoList_page_2024.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/DataTable/data_table_widget.dart';

class PlanoEstudosOrganizacao extends StatefulWidget {
  PlanoEstudosOrganizacao({super.key});

  @override
  State<PlanoEstudosOrganizacao> createState() =>
      _PlanoEstudosOrganizacaoState();
}

class _PlanoEstudosOrganizacaoState extends State<PlanoEstudosOrganizacao> {
  List<String> columns = ['DISCIPLINAS', 'DATAS', 'NOTAS'];

  List<List<String?>> rows = [
    ['Eletromag', '24/04', '0'],
    ['Circuitos CC P1', '18/04', '3.8'],
    ['Circuitos CC P2', '20/05', '3.8'],
    ['Fetran p1', '16/05', 'TODO'],
    ['Fetran testes', '16/05', 'TODO'],
    ['Fetran relatorio pratico', '15/05', 'TODO'],
    ['Circuitos Digitais P1', '08/05', 'TODO'],
    ['Ruby express', '20/05', 'TODO'],
  ];

  void updateRows(List<List<String?>> updatedRows) {
    setState(() {
      rows = updatedRows;
    });
  }

  getDataAtual() {
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('EEEE - dd/MM/yyyy').format(dataAtual);
    return dataFormatada;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QUADRO DE HORARIOS 2024 '),
        ),
        body: Center(
          child: Column(
            children: [
              CustomText(text: getDataAtual(), color: Colors.black),
              Container(
                padding: EdgeInsets.all(16.0),
                child: TabelaGrid(
                  columns: columns,
                  rows: rows,
                  onUpdate: updateRows,
                ),
              ),
              Container(
                height: 1200,
                child: TodoListWidget()
              )
            ],
          ),
        ),
        bottomNavigationBar: navigation());
  }

  Widget navigation() {
    return CustomNavBar(
      navBarItems: [
        NavigationBarItem(
            label: 'Quadro Organizacao', iconData: Icons.home, onPress: () {}),
        NavigationBarItem(
            label: 'TODO LIST 2024',
            iconData: Icons.search,
            onPress: () {
              Get.to(TodoListWidget());
            }),
      ],
    );
  }
}
