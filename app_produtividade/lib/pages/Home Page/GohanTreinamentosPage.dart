import 'package:app_produtividade/pages/Planner%20+%20Scrum/page3.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListPage.dart';
import 'package:app_produtividade/widgets/DrawerNavigation.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:app_produtividade/widgets/Custom/TableCustom.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Custom/CustomNavBar.dart';

class GohanTreinamentosPage extends StatelessWidget {
  const GohanTreinamentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerNavigation(),
      body: _buildBody(context),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'Habit Tracker',
              iconData: Icons.home,
              onPress: () {
                Get.toNamed('/blog');
              }),
          NavigationBarItem(
              label: 'TODO LIST',
              iconData: Icons.search,
              onPress: () {
                Get.to(TodoListPage());
              }),
          NavigationBarItem(
              label: 'ORGANIZE',
              iconData: Icons.person,
              onPress: () {
                Get.to(Page3());
              }),
        ],
      ),
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
    var data = DateTime.now().toIso8601String();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text('Flutter Jedi  - ${data}'),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'COMO TENTAR ORGANIZAR SUA VIDA!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          YoutubeLink(link: 'https://www.youtube.com/watch?v=xFWXl8uLFtk'),
          _dailyQuote(),
          _scheduleSection(),
          _dayObjectives(),
          //_virtualAssistantNotes(),
          //_otherLinks(),
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
          child: TableCustom(
            columns: const ['HORARIO', 'Tarefas'],
            rows: const [
              [
                '07h- 09h',
                'Acordar, tomar café, se exercitar e tomar banho para se organizar para estudar'
              ],
              [
                '09h-12h',
                'Estudar e adquirir conhecimento em algum assunto importante'
              ],
              [
                '13h-15h',
                'Trabalhar em tarefas difíceis com muita determinação!'
              ],
              ['15h-18h', 'Buscar soluções criativas no trabalho!'],
              [
                '18h-20h',
                'Treino e descanso, refletindo seu desempenho durante o dia'
              ],
            ],
          ),
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
      children: const [
        Text(
          'O segredo da vida: https://www.youtube.com/watch?v=xFWXl8uLFtk',
        ),
        Text(
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
