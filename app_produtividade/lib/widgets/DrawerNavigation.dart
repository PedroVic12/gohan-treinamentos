import 'package:app_produtividade/Calistenia-App/portifolio_page.dart';
import 'package:app_produtividade/pages/5%20Hobbies/BlogPage.dart';
import 'package:app_produtividade/pages/Calistenia%20App/page1.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/Page8.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_repository.dart';
import 'package:app_produtividade/pages/Page6.dart';
import 'package:app_produtividade/pages/QuizzPage/views/QuizzPage.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListPage.dart';
import 'package:app_produtividade/pages/page2.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/page3.dart';
import 'package:app_produtividade/pages/page5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Calistenia-App/todo_list_2024.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  navegar(context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const Divider(),
          ListTile(
            title: const Text('Blog + Calendario'),
            leading: const CircleAvatar(
              child: Icon(Icons.calendar_month),
            ),
            onTap: () {
              Get.toNamed('/blog');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Portifolio'),
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            onTap: () {
              navegar(context, PortifolioPage());
              //Get.to(PortifolioPage());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Todo List 2024'),
            onTap: () {
              //Get.to(MyHomePage(title: 'Todo List 2024'));
            },
          ),
          ListTile(
            title: const Text('Quizz app'),
            onTap: () {
              Get.to(const QuizzPage());
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

  Widget navigator(text, onClicar) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          title: Text(text),
          leading: const CircleAvatar(
            child: Icon(Icons.calendar_month),
          ),
          onTap: () {
            onClicar();
          },
        ),
        const Divider(),
      ],
    );
  }
}
