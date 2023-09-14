import 'package:app_produtividade/widgets/DrawerNavigation.dart';
import 'package:app_produtividade/widgets/TableCustom.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';
import 'package:app_produtividade/widgets/card_soft.dart';
import 'package:flutter/material.dart';

class GohanTreinamentosPage extends StatelessWidget {
  const GohanTreinamentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: DrawerNavigation(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Gohan Treinamentos Version 10 - 13/09/23'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_alert),
          tooltip: 'Show Snackbar',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _communicationSection(context),
              _timeSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _communicationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text('Flutter Padawan Dia 6 - 17/02/2023'),
          const Text(
            'COMO TENTAR ORGANIZAR SUA VIDA!',
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          YoutubeLink(link: 'https://www.youtube.com/watch?v=xFWXl8uLFtk'),
          _dailyQuote(),
          _scheduleSection(),
          _dayObjectives(),
          _virtualAssistantNotes(),
          _otherLinks(),
        ],
      ),
    );
  }

  Widget _dailyQuote() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Text(
        'Frase do dia: \n"As Pessoas tem que se esforçar e acreditar em si mesmas, assim damos valor a vida porque temos um futuro para viver" \n- Son Goku',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _scheduleSection() {
    return Column(
      children: [
        const Text(
          'CRONOGRAMA DE HORARIOS',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCustom(),
        ),
      ],
    );
  }

  Widget _dayObjectives() {
    return Column(
      children: const [
        Text('OBJETIVOS DO DIA:'),
        SimpleCard(
            titulo: 'Manha: Planejamento + Leitura',
            card_color: Colors.blue,
            items: [
              ' --> ESTUDES OS CONCEITOS!',
              //... outros itens
            ]),
        //... outros cards
      ],
    );
  }

  Widget _virtualAssistantNotes() {
    return const SimpleCard(
        titulo: 'Assistente Virtual',
        card_color: Colors.yellow,
        items: [
          '- Metodos de Scrum',
          //... outros itens
        ]);
  }

  Widget _otherLinks() {
    return Column(
      children: [
        const Text(
          'O segredo da vida: https://www.youtube.com/watch?v=xFWXl8uLFtk',
        ),
        const Text(
          'https://www.youtube.com/watch?v=cy7i5B18z-c',
          textWidthBasis: TextWidthBasis.longestLine,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 26),
        ),
      ],
    );
  }

  Widget _timeSection() {
    return Column(
      children: [
        _timeContainer(
            title: 'Presente:',
            description: 'O presente é o momento atual, agora.'),
        //... outros containers
      ],
    );
  }

  Widget _timeContainer({required String title, required String description}) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red[200],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 20)),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
