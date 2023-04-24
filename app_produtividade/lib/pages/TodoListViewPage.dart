import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohan_treinamentos_app/models/TodoList.dart';

class TodoListViewPage extends StatefulWidget {
  const TodoListViewPage({super.key});

  @override
  State<TodoListViewPage> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListViewPage> {
  final TodoControllerGetx controller_todo_list = Get.put(TodoControllerGetx());

  @override
  Widget build(BuildContext context) {
    final List<TodoList> aulaList = controller_todo_list.itens
        .where((item) => item.texto.toLowerCase().contains('aula'))
        .toList();
    final List<TodoList> projetoList = controller_todo_list.itens
        .where((item) => item.texto.toLowerCase().contains('projeto'))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Todo List - Modelagem de Itens'),
      ),
      body: ListView.builder(
        itemCount: 2, // número de seções
        itemBuilder: (context, sectionIndex) {
          final sectionTitle =
              sectionIndex == 0 ? 'Aulas' : 'Projetos'; // título da seção
          final sectionItems = sectionIndex == 0 // filtrar itens por seção
              ? aulaList
              : projetoList;

          return sectionItems.isEmpty // não mostrar seção se não houver itens
              ? SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.redAccent),
                            color: Colors.white70,
                          ),
                          child: Text(
                            sectionTitle,
                            style: TextStyle(fontSize: 28.0),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: sectionItems.length,
                      itemBuilder: (context, index) {
                        final item = sectionItems[index];
                        //print('Subtiulo = ${item.subTitulo}');
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.greenAccent,
                            child: Column(
                              children: [
                                ListTile(
                                  //?Titulo do texto
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 5),
                                    child: Text(
                                      item.texto,
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  //? Descrição do Texto
                                  subtitle: Column(
                                    children: [
                                      if (item.subTitulo.isNotEmpty)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: item.subTitulo.length,
                                          itemBuilder: (context, subIndex) {
                                            final subItem =
                                                item.subTitulo[subIndex];
                                            //print(subItem);
                                            return Text(
                                              subItem,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            );
                                          },
                                        ),
                                      if (item.subTitulo.isEmpty)
                                        const Text('sem descrição'),
                                    ],
                                  ),
                                  //? Checkbox
                                  trailing: Checkbox(
                                    value: item.done,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        item.done = value!;
                                        print('\nTarefa Concluida!');
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
                  ],
                );
        },
      ),
    );
  }
}

// Widget para mostrar cada subitem em uma lista
Widget buildSubItem(String subItem) {
  return ListTile(
    title: Text(subItem),
    dense: true,
  );
}

class TodoControllerGetx extends GetxController {
  var itens = <TodoList>[
    TodoList(texto: '7 Days Aulas Data Science', done: false, subTitulo: []),
    //TodoList(texto: '7 Days MongoDB', done: false, subTitulo: []),
    TodoList(
        texto: 'Aulas UFF + 5 Exercícios cada matéria',
        done: false,
        subTitulo: [
          '- Estudar Eletromagnetismo | P1 = 24/04',
          '- Sinais e Sistemas com muitos exercícios',
          '- Lista de Exercícios Circuitos ',
          '- Revisar aula passada de Maquinas Térmicas | P1 = 10/05'
        ]),
    // TodoList(
    //     texto: 'Aula Dart + Arquitetura Limpa (MVC)',
    //     done: false,
    //     subTitulo: ['- Programação Funcional', '- Backend com api']),
    TodoList(
        texto: 'Aula IoT Specialist Arduino | C++ Developer',
        done: false,
        subTitulo: ['TRABALHO ELETRÔNICA IRRIGAÇÃO INTELIGENTE']),
    //TodoList(
    //! Não fiz ainda
    //texto: 'Aula Machine Learning Specialist Python',
    //done: false,
    //subTitulo: []),
    TodoList(texto: 'Aula GetX + Flutter Padawan', done: false, subTitulo: [
      "- Flutter Design Telegram: Bloco 3 - 00:32 minutos",
      '- Api Calls',
      '- DataBase Integration (Autenticação, Data Storage, Cloud Functions)'
    ]),
    TodoList(
        texto: 'Aula Power Bi + Python para Data Science',
        done: false,
        subTitulo: [
          '- Capitulo 6 - DSA - Modulos e Pacotes',
          "- Aula 1 Imersao power BI"
        ]),
    TodoList(texto: 'PROJETO JARVIS - Robótica', done: false, subTitulo: []),
    TodoList(texto: 'PROJETO CIÊNCIA DE DADOS', done: false, subTitulo: []),
    TodoList(texto: 'PROJETO IoT/ Smart Home', done: false, subTitulo: []),
    TodoList(texto: 'PROJETO Flutter Freelancer', done: false, subTitulo: []),
  ].obs;

  void onItemChanged(int index, bool value) {
    itens[index].done = value;
    itens.refresh(); //  para atualizar a lista

    update(); //Método Build do Getx
  }
}

/**
 * -> O método refresh() do GetX é utilizado para atualizar a tela quando houver alterações no estado da aplicação. 
 * Ele é comumente usado para atualizar a interface gráfica após uma alteração no modelo de dados ou estado da aplicação.
 * 
 * 
 O método refresh() pode ser usado em diferentes situações, como por exemplo:

1) Quando o modelo de dados for alterado: se você está usando o GetX para gerenciar o estado da sua aplicação e alterou o modelo de dados, você pode chamar o refresh() para atualizar a interface gráfica com as novas informações.

2) Quando há alterações no estado da aplicação: se você tem alguma variável ou estado que pode ser alterado em tempo de execução, você pode chamar o refresh() para atualizar a interface gráfica com as novas informações.

3) Quando há alterações no idioma ou tema da aplicação: se a sua aplicação suporta múltiplos idiomas ou temas, você pode chamar o refresh() para atualizar a interface gráfica com as novas configurações.

Lembre-se que é importante evitar o uso excessivo do refresh() para não comprometer o desempenho da aplicação. Ele deve ser usado apenas quando necessário para atualizar a interface gráfica com as novas informações.
 * 
 * 
 */