import 'package:app_produtividade/pages/5%20Hobbies/CRUD%20HIVE/controllers/contador_controller.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarWidget.dart';
import 'package:app_produtividade/pages/5%20Hobbies/widgets/HobbyList.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/KanbanPage.dart';
import 'package:app_produtividade/widgets/CarregamentoWidget.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:app_produtividade/widgets/Layout/MapaMentalWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/BotaoNavegaçao.dart';
import '../../widgets/Custom/CustomNavBar.dart';
import '../../widgets/Custom/TableCustom.dart';
import '../Todo List/TodoListPage.dart';
import '../Todo List/TodoListViewPage.dart';
import 'CRUD HIVE/views/notes_screen.dart';
import 'CRUD HIVE/views/task_view.dart';
import 'Hobbies/HobbyModel.dart';
import 'Hobbies/HobbyController.dart';
import 'package:intl/intl.dart';

// TODO -> You only Need 5 Hobbies
//
//// TODO -> Faculdade
///
// TODO -> Estágio
///
/// TODO -> Freelancer App + Chatbot

/// TODO -> Organização + Planejamento + Metas

class BlogPage2 extends StatefulWidget {
  BlogPage2({super.key});

  @override
  State<BlogPage2> createState() => _BlogPage2State();
}

class _BlogPage2State extends State<BlogPage2> {
  final LocalStorage storage = LocalStorage('hobbies_storage');
  final HobbyController _controller = Get.put(HobbyController());

  final List<Hobby> hobbies = [
    Hobby(
        title: "One to make your money",
        description:
            "Estágio em Engenharia, Citta Delivery App, Iniciação Cientifica"),
    Hobby(
        title: "One to keep you in shape",
        description:
            "Calistenia App + Movimentos Calistenicos, Treino Academia + Força"),
    Hobby(
        title: "One to build Knowledge",
        description: " 2 Disciplinas da UFF por Dia , 2 Aula + 5 Exericios"),
    Hobby(
        title: "One to grow your mindset",
        description: "Fazer 1 Projeto que Resolva problemas"),
    Hobby(
        title: "One to stay creactive",
        description:
            "Ler 1 Livro, Documentario, Material de Apoio de algo Revolucionario"),
  ];
  int get totalHobbiesCount =>
      hobbies.fold(0, (previousValue, hobby) => previousValue + hobby.count);

  @override
  void initState() {
    super.initState();
    _loadCounts();
  }

  getDataAtual() {
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('EEEE - dd/MM/yyyy').format(dataAtual);
    return dataFormatada;
  }

  _loadCounts() async {
    await storage.ready;

    for (int i = 0; i < hobbies.length; i++) {
      hobbies[i].count = storage.getItem('hobby_count_$i') ?? 0;
    }
    setState(() {});
  }

  _saveCounts() async {
    for (int i = 0; i < hobbies.length; i++) {
      storage.setItem('hobby_count_$i', hobbies[i].count);
    }
  }

  _resetCounts() {
    for (var hobby in hobbies) {
      hobby.count = 0;
    }
    _saveCounts();
    setState(() {});

    Get.snackbar(
      'Rotinas Resetadas!',
      'Tenha um otimo inicio de semana',
      showProgressIndicator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Gohan Treinamentos',
          size: 20,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        actions: [
          CircleAvatar(
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetCounts,
              tooltip: "Reset counts",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO -> Transformar num Widget

          Center(
              child: Card(
                  child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              getDataAtual(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ))),
          const CustomText(
            text: 'You Only Need 5 hobbies',
            weight: FontWeight.bold,
          ),

          DesempenhoCardWidget(
              data: '16/10/23',
              total: 16,
              hiperfoco: 'Money',
              rendimento: 'Medio',
              onLongPressCard: () {
                Get.to(HistoricoDesempenhoCardWidget());
              }),

          //! CODIGO LIMPO MAS MOSTRA APENAS 1 HobbyList(controller: _controller),

          Expanded(
            child: ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amber.shade300,
                  margin: const EdgeInsets.all(8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      hobbies[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemBlue),
                    ),
                    subtitle: Text(
                      hobbies[index].description,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          child: Text(
                            hobbies[index].count.toString(),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                hobbies[index].count++;
                                _saveCounts();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Divider(),
                Text("Desempenho da semana: ${totalHobbiesCount}/35",
                    style: const TextStyle(fontSize: 20)),
                LinearProgressIndicator(
                  value: totalHobbiesCount / 35,
                  color: Colors.black,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.grey[200],
                ),
                Divider(),
              ],
            ),
          ),

          //BotaoNavegacao(        pagina: ContadorPage(), titlePagina: 'Pagina de Incrementador'),

          //CardProdutividade()
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'Calendário',
              iconData: Icons.date_range_outlined,
              onPress: () {
                Get.to(CalendarioWidget());
              }),
          NavigationBarItem(
              label: 'Todo List',
              iconData: Icons.search,
              onPress: () {
                Get.to(TodoListPage());
              }),
          NavigationBarItem(
              label: 'KANBAN',
              iconData: Icons.add_chart_outlined,
              onPress: () {
                Get.toNamed('/KanbanBoard');
              }),
        ],
      ),
    );
  }
}

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
            Divider(),
            DesempenhoCardWidget(
                data: '09/10/23',
                total: 18,
                hiperfoco: 'Creative',
                rendimento: 'Fraco',
                onLongPressCard: () {
                  Get.to(HistoricoDesempenhoCardWidget());
                }),
            Divider(),
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
            BotaoNavegacao(pagina: TaskView(), titlePagina: 'CRUD HIVE'),
          ],
        ),
      ),
    );
  }
}
