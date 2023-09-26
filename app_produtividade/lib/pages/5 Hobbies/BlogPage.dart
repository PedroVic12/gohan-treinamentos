import 'package:app_produtividade/pages/5%20Hobbies/CRUD%20HIVE/controllers/contador_controller.dart';
import 'package:app_produtividade/pages/5%20Hobbies/CalendarioPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/widgets/HobbyList.dart';
import 'package:app_produtividade/widgets/CarregamentoWidget.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/BotaoNavegaçao.dart';
import '../../widgets/Custom/TableCustom.dart';
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
              'Segunda, 25/09/2023',
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
            padding: const EdgeInsets.only(bottom: 50.0),
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

          BotaoNavegacao(pagina: CalendarioPage(), titlePagina: 'Calendario'),

          BotaoNavegacao(pagina: TaskView(), titlePagina: 'CRUD HIVE'),
          //CardProdutividade()
        ],
      ),
    );
  }
}

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs; // Observável para armazenar o índice selecionado

  // Método para alterar o índice selecionado
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

class BarraInferiorNavegacao extends StatelessWidget {
  const BarraInferiorNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    final _bottomBarController = Get.put(BottomBarController());

    return BottomNavigationBar(
      currentIndex: _bottomBarController.selectedIndex.value,
      onTap: _bottomBarController.changeTabIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }
}
