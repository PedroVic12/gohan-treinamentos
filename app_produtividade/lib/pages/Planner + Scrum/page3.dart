import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/KanbanPage.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/ScrumPlanner.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/TaskScreen.dart';
import 'package:app_produtividade/widgets/BotaoNavega%C3%A7ao.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:app_produtividade/widgets/Custom/TableCustom.dart';
import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';
import 'package:get/get.dart';

class Page3 extends StatelessWidget {
  Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3 - Scrum, Kanban e Produtividade'),
        backgroundColor: Colors.black45,
        actions: [
          IconButton(
            onPressed: () {
              //Get.to(PlannerScreen());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
                child:
                    Text('Quadro de Organização - Pagina 163 do Livro Scrum')),

            ScrumPlanner(
              headers: const [
                'BackLog',
                'A Fazer',
                'Fazendo',
                'Feito!',
              ],
              sideLabels: const [
                'Jedi Estudante',
                'Programador',
                'Engenheiro IoT',
                'Cientista de Dados',
              ],
            ),

            TableCustom(columns: const [
              'Entregas',
              'Prazos em dias(19/09/23)'
            ], rows: const [
              ['Relatório OS', ' 4'],
              ['Modelo Preditivo', ''],
              ['Scanner PDF', ''],
              ['Camorim APP', ''],
            ]),

            TableCustom(
              columns: const ['XP Programing'],
              rows: const [
                ['Jogo do planejamento'],
                ['Fases Pequenas'],
                ['Metafora StoryTelling'],
                ['Desing Simples - KISS'],
                ['Testes pelo cliente'],
                ['Ritmo Sustentavel (40/5) = 8h semanais'],
                ['Padronização do Código'],
                ['Refatoração'],
                ['Entrega Contínua e Agil']
              ],
            ),

            TableCustom(columns: const [
              'Modelo agil'
            ], rows: const [
              ['Entregas parciaos do produto ao longo do processo'],
              ['Procoesso iterativo de desenvolvilmento'],
              ['Testes ao longo do processo, com ajustes constantes'],
              ['Alterações e ajustes implementados com facilidade'],
              ['Risco de retrabalhos e atrasos baixo'],
              ['Erros podem ser sanados no meio do projeto'],
            ]),

            TableCustom(columns: const [
              'Valores do Manifesto Agil '
            ], rows: const [
              ['Individuos e interaõ~es acima de processos e ferramentos'],
              ['Procoesso iterativo de desenvolvilmento'],
              ['Testes ao longo do processo, com ajustes constantes'],
              ['Alterações e ajustes implementados com facilidade'],
              ['Risco de retrabalhos e atrasos baixo'],
              ['Erros podem ser sanados no meio do projeto'],
            ]),

            TableCustom(columns: const [
              'Principios da Metodologia Agil '
            ], rows: const [
              ['Individuos e interaõ~es acima de processos e ferramentos'],
              ['Procoesso iterativo de desenvolvilmento'],
            ]),

            ElevatedButton(
                onPressed: () {
                  Get.to(PlannerScreen());
                },
                child: Text('Pagina de Tarefas')),

            //GridLayout(),
            //Expanded(child: ColunasCapitulos())
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'SCRUM',
              iconData: Icons.home,
              onPress: () {
                Get.to(Page3());
              }),
          NavigationBarItem(
              label: 'KANBAN',
              iconData: Icons.add_comment_sharp,
              onPress: () {
                Get.to(KanbanPage());
              }),
          NavigationBarItem(
              label: 'PLANO DE AÇÃO',
              iconData: Icons.person,
              onPress: () {
                //Get.to(TodoListViewPage());
              }),
        ],
      ),
    );
  }
}

class ColunasCapitulos extends StatelessWidget {
  const ColunasCapitulos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SimpleCard(
            titulo: 'Capitulo 1 - A maneira como o mundo funciona esta errada!',
            card_color: Colors.red,
            items: [
              '--> Planejar é util. Seguir cegamente os planos é burrice:\n\nÉ muito tentador desenhas inumeros gráficos. Todo o trabalho que precisa ser feito em um projeto de grande porte apareceli, detalhado, para todos verem - mas, quando deparam com a realidade, os planos desabam. Inclua no seu método de trabalho a possibilidade de mudança, descoberta e inovação.',
              '\n--> Inspeção e adaptação:\nDe tempos em tempos, pare o que está fazendo, revise o que ja fez e verifique se deveria continuar fazendo a mesma coisa ou se existe uma maneira melhor de fazer.',
              '\n--> Mude ou Morra:\nAgarrar-se ao modo antigo de fazer as coisas -comando, controle e previsibilidade rígida - só resultara em fracassos. Nesse meio-tempo, o concorrente que estiver disposto a inovar vai deixar voce para trás. (NÂO PARAMOS DE INOVAR!)',
              '\n --> Fracasse rápido para que possa corrigir o problema quanto antes:\nA cultura corporativa costuma dar mais valor a formulários, procedimentos e reuniões do que a criação de valor concreto, que possa ser verificado a curtos intervalos de tempo pelos usuários. O trabalho que não resulta em valor real é loucura! Trabalhar em um produto em ciclos curtos permite que se obtenha o feedback do usuário logo no começo do desenvolvimento. Assim, voce pode eliminar imediatamente tudo aquilo que constitui um desperdicio obvio de esforço'
            ]),
        SimpleCard(
            titulo: 'Como ser o Super Produtivo',
            card_color: Colors.red,
            items: [
              'Scrum',
              'Week Planner',
              'Horario de estudo + Horario de trabalho',
              'Ter clareza das prioridades no dia!',
              'Ter Metas com datas Reais!',
              '- Saber lidar com Imprevistos!'
            ]),
      ],
    );
  }
}
