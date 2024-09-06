import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/Board/kanban_board.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/Board/kanban_controller.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/Custom/CustomNavBar.dart';
import 'Board/kanban_column.dart';

class KanbanPage extends StatelessWidget {
  KanbanPage({Key? key}) : super(key: key);

  final cor1 = Colors.blueGrey;
  final controller =
      Get.put(KanbanController()); // Inicializando o controlador aqui
  final newTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
      ),
      body: ListView(children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.view_carousel),
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text('Quadro Kanban')
          ],
        ),
        KanbanBoard(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Adicionar nova tarefa"),
                content: TextField(
                  controller: newTaskController,
                  decoration: InputDecoration(hintText: "Titulo da tarefa"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final newTaskTitle = newTaskController.text;
                      if (newTaskTitle.isNotEmpty) {
                        controller.columns['backlog']!
                            .add(ItemTrabalho(title: newTaskTitle));
                      }
                      newTaskController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("Adicionar"),
                  ),
                  TextButton(
                    onPressed: () {
                      newTaskController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: '5 Hobbies',
              iconData: Icons.home,
              onPress: () {
                Get.to(Page3());
              }),
          NavigationBarItem(
              label: 'Todo List',
              iconData: Icons.add_comment_sharp,
              onPress: () {
                //Get.to(TodoListPage());
              }),
          NavigationBarItem(
              label: 'Tab 3',
              iconData: Icons.person,
              onPress: () {
                //Get.to(TodoListViewPage());
              }),
        ],
      ),
    );
  }
}
