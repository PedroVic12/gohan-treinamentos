import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/models/TodoList.dart';

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
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.redAccent),
                            color: Colors.white70,
                          ),
                          child: Text(
                            sectionTitle,
                            style: const TextStyle(fontSize: 28.0),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
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
                                      style: const TextStyle(
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
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: item.subTitulo.length,
                                          itemBuilder: (context, subIndex) {
                                            final subItem =
                                                item.subTitulo[subIndex];
                                            //print(subItem);
                                            return Text(
                                              subItem,
                                              style: const TextStyle(
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

//!Controlador que alimenta a todoLIST
class TodoControllerGetx extends GetxController {
  var itens = <TodoList>[
    //TodoList(texto: '7 Days Aulas Data Science', done: false, subTitulo: []),
    //TodoList(texto: '7 Days MongoDB', done: false, subTitulo: []),
    TodoList(texto: 'Produtividade + Hábitos [aula] ', subTitulo: [
      '- Organização plano de estudos com Metas semanais e do mes',
      '- Ler 1 Capitulo de um Livro',
      '- Fechar 5 Abas de cada Navegador',
      '- Regra 80/20 e 5/25'
      //'- Organização desse App'
    ]),
    TodoList(
        texto: '2 Aulas UFF + 5 Exercícios cada matéria como Revisão',
        done: false,
        subTitulo: [
          '- Eletromagnetismo | Pegar aula passada + Lista de exercicios| P2 = ',
          '- Sinais e Sistemas | Lista exercícios, Convolução, LIT, Tempo Discreto | P1 = 22/05',
          '- Circuitos Corrente Continua |Análise Modal |Lei de corrente, nos, Norton, Thevikein, Lista de Exercícios + Simulador = 10/05 ',
          '- Maquinas Térmicas | Avaliação Exercícios | P2 =',
          '- Estrutura de Dados | Algorítimos Monte Carlo | 19/05 '
        ]),
    // TodoList(
    //     texto: 'Aula Dart + Arquitetura Limpa (MVC)',
    //     done: false,
    //     subTitulo: ['- Programação Funcional', '- Backend com api']),
    TodoList(
        texto: 'Aula IoT Specialist Arduino | C++ Developer',
        done: false,
        subTitulo: [
          'TRABALHO ELETRÔNICA IRRIGAÇÃO INTELIGENTE',
          'Algorítimos de Monte Carlo'
        ]),
    //TodoList(
    //! Não fiz ainda
    //texto: 'Aula Machine Learning Specialist Python',
    //done: false,
    //subTitulo: []),
    TodoList(texto: 'Aula GetX + Flutter Padawan', done: false, subTitulo: [
      '- 5 Widgets para estudo',
      '- Api Calls',
      '- Saber lidar com erros e Debugar em Flutter',
      '- DataBase Integration (Autenticação, Data Storage, Cloud Functions, CRUD com Google Sheets)'
    ]),
    TodoList(texto: 'Aula Python para Data Science', done: false, subTitulo: [
      '- Capitulo 6 - DSA - Módulos e Pacotes',
      "- Data Science Roadmap - 6 Months",
      '- Livro Marketing Digital para Data Science',
      '- Aulas de  como fazer relatórios em PDF e Dashboards com Excel e Tableau'
    ]),
    //TodoList(texto: 'PROJETO JARVIS - Robótica', done: false, subTitulo: []),
    TodoList(
        texto: 'PROJETO CIÊNCIA DE DADOS - Marketing Digital + Relatórios',
        done: false,
        subTitulo: ['- Analise Exploratoria', '- Regressão Linear']),
    TodoList(
        texto: 'PROJETO Camorim',
        done: false,
        subTitulo: ["- Relatorios tecnicos"]),
    TodoList(texto: 'PROJETO Flutter Freelancer', done: false, subTitulo: [
      '- Botões com Horários disponíveis',
      '- Outras paginas do App (Login, ServicosPage, HomePage)'
    ]),
    TodoList(texto: 'PROJETO GeoMarketing', done: false, subTitulo: []),
    TodoList(
        texto: 'PROJETO Portfolio + Blog com Flutter para Estudos',
        subTitulo: ['- HomePage', '- Markdown para Flutter'])
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
