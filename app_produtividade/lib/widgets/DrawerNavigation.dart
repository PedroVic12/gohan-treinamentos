import 'package:app_produtividade/C3PO/assistente.dart';
import 'package:app_produtividade/Calistenia-App/portifolio_page.dart';
import 'package:app_produtividade/pages/PlanosGENAI/Planos%20de%20treino/rascunho_ia_meal_planner.dart';
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

import '../pages/PlanosGENAI/Plano de Estudos/todo_list_2024.dart';

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
            title: const Text('c3po assistente virtual'),
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            onTap: () {
              navegar(context, C3poGenaiAssistentePessoal());
              //Get.to(PortifolioPage());
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
          ListTile(
            title: const Text('Notas e Cards app'),
            leading: const CircleAvatar(
              child: Icon(Icons.book),
            ),
            onTap: () {
              //Get.to(const QuizzPage());
            },
          ),
          const Divider(),
          const Divider(),
          ListTile(
            title: const Text('Todo List 2024'),
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            onTap: () {
              navegar(context, TodoList2024());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Quizz app'),
            leading: const CircleAvatar(
              child: Icon(Icons.book),
            ),
            onTap: () {
              Get.to(const QuizzPage());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Plano de Treino - GENAI'),
            leading: const CircleAvatar(
              child: Icon(Icons.wine_bar),
            ),
            onTap: () {
              Get.to(const PlanoDeTreinoWidget());
            },
          ),
          const Divider(),
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

  Widget navigator(String text, onClicar) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          title: Text(text),
          leading: const CircleAvatar(
            child: Icon(Icons.calendar_month),
          ),
          onTap: () {
            onClicar;
          },
        ),
        const Divider(),
      ],
    );
  }
}
