import 'package:app_produtividade/pages/Planner%20+%20Scrum/widgets/ScrumPlanner.dart';
import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';

class Page3 extends StatelessWidget {
  Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3 - Scrum e Produtividade'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Quadro de Organização - Pagina 163 do Livro Scrum'),

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

            //GridLayout(),
            //Expanded(child: ColunasCapitulos())
          ],
        ),
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
