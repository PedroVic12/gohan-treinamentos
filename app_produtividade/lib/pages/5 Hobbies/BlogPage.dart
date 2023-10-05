import 'package:app_produtividade/pages/5%20Hobbies/CRUD%20HIVE/controllers/contador_controller.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarioPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/widgets/HobbyList.dart';
import 'package:app_produtividade/widgets/CarregamentoWidget.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gohan Treinamentos'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounts,
            tooltip: "Reset counts",
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO -> Transformar num Widget

          const Center(
              child: Card(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Segunda, 02/10/2023',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ))),
          const Text('You Only Need 5 hobbies'),

          const Card(
            color: Colors.grey,
            child: ListTile(
              title: Text('Total da semana (18/09/2023): 11'),
              trailing: Text('Rendimento: {fraco}'),
              leading: Text('Foco maior {Money}'),
            ),
          ),

          DesempenhoCardWidget(
              data: '25/09/23', rendimento: 'Médio', hiperfoco: 'Money'),

          const Text('Entender -> Aprender -> Praticar -> Aplicar'),

          const Text('Code -> Debug -> Rest -> Motivation'),

          const Text(
              'Pesquisa -> Planejamento -> Execução -> Correção de falhas'),

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
                          color: CupertinoColors.activeBlue),
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
                        // Update the onPressed callback for the IconButton
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              hobbies[index].count++;
                              _saveCounts();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 25),
            child: Column(
              children: [
                Text("Desempenho da semana: ${totalHobbiesCount}/35",
                    style: const TextStyle(fontSize: 20)),
                LinearProgressIndicator(
                  value: totalHobbiesCount / 35,
                  color: Colors.black,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.grey[200],
                )
              ],
            ),
          ),

          //BotaoNavegacao(        pagina: ContadorPage(), titlePagina: 'Pagina de Incrementador'),

          BotaoNavegacao(pagina: TaskView(), titlePagina: 'CRUD HIVE'),
          //CardProdutividade()
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'Calendário',
              iconData: Icons.date_range_outlined,
              onPress: () {
                Get.to(CalendarioPage());
              }),
          NavigationBarItem(
              label: 'Todo List',
              iconData: Icons.search,
              onPress: () {
                Get.to(TodoListPage());
              }),
          NavigationBarItem(
              label: 'Tab 3',
              iconData: Icons.person,
              onPress: () {
                Get.to(TodoListViewPage());
              }),
        ],
      ),
    );
  }
}

class DesempenhoCardWidget extends StatelessWidget {
  final String data;
  final String hiperfoco;
  final String rendimento;
  DesempenhoCardWidget(
      {super.key,
      required this.data,
      required this.hiperfoco,
      required this.rendimento});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CustomText(
            text: 'Total da semana ($data): 19',
            color: Colors.white,
            size: 14,
          ),
        ),
        trailing: CustomText(
          text: 'Rendimento: $rendimento',
          color: Colors.white,
          size: 14,
        ),
        leading: CustomText(
          text: 'Foco maior: $hiperfoco',
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }
}
