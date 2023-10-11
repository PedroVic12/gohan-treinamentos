import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/QuadroKanban.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/Custom/CustomNavBar.dart';
import '../../widgets/drag_BOX.dart';
import 'Board/kanban_board.dart';

class KanbanPage extends StatelessWidget {
  const KanbanPage({Key? key}) : super(key: key);

  final cor1 = Colors.blueGrey;

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
        DraggableExample(),
        KanbanBoard(),
      ]),
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
