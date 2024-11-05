import 'package:app_produtividade/widgets/BotaoNavega%C3%A7ao.dart';
import 'package:app_produtividade/widgets/Layout/MapaMentalWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/Custom/CustomText.dart';

class DesempenhoCardWidget extends StatelessWidget {
  final String data;
  final int total;
  final String hiperfoco;
  final String rendimento;
  final VoidCallback onLongPressCard;
  DesempenhoCardWidget(
      {super.key,
      required this.data,
      required this.hiperfoco,
      required this.rendimento,
      on,
      required this.onLongPressCard,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      child: ListTile(
        onLongPress: onLongPressCard,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CustomText(
            text: 'Semana ($data):\n\t\tTotal:$total',
            color: Colors.white,
            size: 14,
          ),
        ),
        trailing: CustomText(
          text: 'Rendimento:\n$rendimento',
          color: Colors.white,
          size: 14,
        ),
        leading: CustomText(
          text: 'Foco maior:\n$hiperfoco',
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }
}

class HistoricoDesempenhoCardWidget extends StatelessWidget {
  const HistoricoDesempenhoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 2,
        title: Text('Appbar'),
      ),
      body: Card(
        child: ListView(
          children: [
            DesempenhoCardWidget(
                data: '04/06/24',
                total: 21,
                hiperfoco: 'Knowlodge',
                rendimento: 'Pouca atividade e força de vontade',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '06/05/24',
                total: 21,
                hiperfoco: 'Knowlodge',
                rendimento: 'Pouca atividade e força de vontade',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '15/04/24',
                total: 23,
                hiperfoco: 'Mindset',
                rendimento: 'Muito trabalho pouca produtividade',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '08/04/24',
                total: 23,
                hiperfoco: 'Estudos',
                rendimento: 'depressivo sóbrio ',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '04/04/24',
                total: 27,
                hiperfoco: 'Mindset - Projetos',
                rendimento: 'energia alta + sorte',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '01/04/24',
                total: 25,
                hiperfoco: 'Money - INICIO',
                rendimento: 'fraco',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '04/03/24',
                total: 25,
                hiperfoco: 'Money - INICIO',
                rendimento: 'karate - caos-  peixes',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '26/02/24',
                total: 30,
                hiperfoco: 'Resolver problemas',
                rendimento: 'sol em peixes',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '19/02/24',
                total: 34,
                hiperfoco: 'Money',
                rendimento: 'karate - caos-  peixes',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '12/02/24',
                total: 23,
                hiperfoco: 'Money',
                rendimento: 'Carnaval',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '05/02/24',
                total: 34,
                hiperfoco: 'Money',
                rendimento: 'Pouca atitude',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '29/01/24',
                total: 36,
                hiperfoco: 'Money',
                rendimento: 'Quantidade != Qualidade',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '29/01/24',
                total: 36,
                hiperfoco: 'Money',
                rendimento: 'Quantidade != Qualidade',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '22/01/24',
                total: 32,
                hiperfoco: 'Money',
                rendimento: 'SSJ',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '15/01/24',
                total: 24,
                hiperfoco: 'Shape',
                rendimento: 'Bom',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '08/01/24',
                total: 30,
                hiperfoco: 'Money + Muscle',
                rendimento: 'Sayajin',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '18/12/23',
                total: 25,
                hiperfoco: 'Money',
                rendimento: 'Bom',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '11/12/23',
                total: 29,
                hiperfoco: 'Money',
                rendimento: 'Purpouse',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '04/12/23',
                total: 23,
                hiperfoco: 'Money',
                rendimento: 'Chatbot + Kyogre',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '27/11/23',
                total: 18,
                hiperfoco: 'Money',
                rendimento: 'Depressivo determiando',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '13/11/23',
                total: 26,
                hiperfoco: 'Money',
                rendimento: 'Aurea Limpa',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            DesempenhoCardWidget(
                data: '06/11/23',
                total: 27,
                hiperfoco: 'Money',
                rendimento: 'Energia Alta - quase ssj',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            const Divider(),
            DesempenhoCardWidget(
                data: '30/10/23',
                total: 13,
                hiperfoco: 'Money',
                rendimento: 'Fraco',
                onLongPressCard: () {}),
            const Divider(),
            DesempenhoCardWidget(
                data: '23/10/23',
                total: 26,
                hiperfoco: 'Creative',
                rendimento: 'Energia Alta',
                onLongPressCard: () {}),
            const Divider(),
            DesempenhoCardWidget(
                data: '09/10/23',
                total: 18,
                hiperfoco: 'Creative',
                rendimento: 'Fraco',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            const Divider(),
            DesempenhoCardWidget(
                data: '02/10/23',
                total: 19,
                hiperfoco: 'Money',
                rendimento: 'Médio',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            Divider(),
            const Card(
              color: Colors.grey,
              child: ListTile(
                title: Text('Total da semana (18/09/2023): 11'),
                trailing: Text('Rendimento: {fraco}'),
                leading: Text('Foco maior {Money}'),
              ),
            ),
            Divider(),
            DesempenhoCardWidget(
                data: '25/09/23 ',
                total: 17,
                rendimento: 'Médio',
                hiperfoco: 'Money',
                onLongPressCard: (() {})),
            CirclesAndArrows(),
            const Card(
              child: Column(children: [
                const Text('Entender -> Aprender -> Praticar -> Aplicar'),
                const Text('Code -> Debug -> Rest -> Motivation'),
                const Text(
                    'Pesquisa -> Planejamento -> Execução -> Correção de falhas'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
