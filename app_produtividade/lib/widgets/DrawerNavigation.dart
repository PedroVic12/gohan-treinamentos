import 'package:app_produtividade/pages/5%20Hobbies/BlogPage.dart';
import 'package:app_produtividade/pages/Calistenia%20App/page1.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/Page8.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_repository.dart';
import 'package:app_produtividade/pages/Page6.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListPage.dart';
import 'package:app_produtividade/pages/page2.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/page3.dart';
import 'package:app_produtividade/pages/page5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Divider(),
          ListTile(
            title: const Text('Blog + Calendario'),
            leading: CircleAvatar(
              child: Icon(Icons.calendar_month),
            ),
            onTap: () {
              Get.toNamed('/blog');
            },
          ),
          Divider(),

          ListTile(
            title: const Text('Todo List 2024'),
            onTap: () {
              Get.to(MyHomePage( title: 'Todo List 2024'));
            },
          ),

              ListTile(
            title: const Text('Quizz app'),
            onTap: () {
              Get.to(QuizzPage());
            },
          ),


          ListTile(
            title: const Text('Page 1 - Calistenia APP'),
            onTap: () {
              Get.toNamed('/calisteniaApp');
            },
          ),
          ListTile(
            title: const Text('Page 2 - Your SuperPower'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page2(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
                'Page 3 - Conceitos de Scrum, Produtividade, Kanban e organização'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page3(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Page 4 - Organizador - TODO LIST'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoListPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Page 5 - Como o Universo funciona'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Page5(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Page 6 - Pomodoro Timer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page6(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Page 8 - Lista de Filmes'),
            onTap: () async {
              Get.toNamed('/page8');
            },
          ),
        ],
      ),
    );
  }
}
