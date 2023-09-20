import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesModel.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/contador_controller.dart';
import 'package:app_produtividade/widgets/CarregamentoWidget.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/BotaoNavegaçao.dart';
import 'CRUD HIVE/views/notes_screen.dart';

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

    // ... adicione outros hobbies aqui
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
            icon: Icon(Icons.refresh),
            onPressed: _resetCounts,
            tooltip: "Reset counts",
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO -> Transformar num Widget

          const Text('Segunda, 12/06/2023'),

          const Text('You Only Need 5 hobbies'),

          const Text('Entender -> Aprender -> Praticar -> Aplicar'),

          const Text('Code -> Debug -> Rest -> Motivation'),

          const Text(
              'Pesquisa -> Planejamento -> Execução -> Correção de falhas'),

          //Expanded(child: CardHobbiesWidget()),
          const Card(
            child: Text(
                '1 shape | 1 Knowledge | 1 Creative | 0 MindSet | 0 Money'),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(hobbies[index].title),
                    subtitle: Text(hobbies[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(hobbies[index].count.toString()),
                        // Update the onPressed callback for the IconButton
                        IconButton(
                          icon: Icon(Icons.add),
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
                    style: TextStyle(fontSize: 20)),
                LinearProgressIndicator(
                  value: totalHobbiesCount / 35,
                  color: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.grey[200],
                )
              ],
            ),
          ),

          BotaoNavegacao(
              pagina: ContadorPage(), titlePagina: 'Pagina de Incrementador'),
          BotaoNavegacao(pagina: NoteScreen(), titlePagina: 'CRUD HIVE'),
          //CardProdutividade()
        ],
      ),
    );
  }
}
