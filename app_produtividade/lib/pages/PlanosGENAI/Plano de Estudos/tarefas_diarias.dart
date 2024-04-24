import 'package:app_produtividade/pages/PlanosGENAI/PDF%20data%20Analysis/cadastro_simples.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    ['Eletromag', '24/04', '2.0'],
    ['Circuitos CC', '18/04', '3.8'],
    ['Fetran', '30/04', 'TODO'],
    ['Ruby express', '27/04', 'TODO'],
  ];

  void updateRows(List<List<String?>> updatedRows) {
    setState(() {
      rows = updatedRows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QUADRO DE HORARIOS '),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: TabelaGrid(
              columns: columns,
              rows: rows,
              onUpdate: updateRows,
            ),
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
            label: 'TODO LIST',
            iconData: Icons.search,
            onPress: () {
              Get.to(CadastroSimples());
            }),
      ],
    );
  }
}
