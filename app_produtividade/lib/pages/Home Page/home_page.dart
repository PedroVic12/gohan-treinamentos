import 'package:app_produtividade/widgets/DrawerNavigation.dart';
import 'package:flutter/material.dart';

import 'package:app_produtividade/widgets/Custom/TableCustom.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';

// TODO -> Alarmes diversos para manha, tarde e noite
// TODO -> COntador de numero de pomodoros ( 2 pomodoros por Tarefa = Ideial | 4 pomodoros = Perfeito)
// TODO -> Gerar Tarefas aleatorias Manha, Tarde e Noite
// TODO -> Metas Diarias (4 Tarefas) | Metas Semanais (Aplicação e deploy de 1 Projeto) | Metais Mensais (Renda Extra com algum Projeto + Uso diario de algum APP e postar suas melhorias no Blog + Linkeding)
// TODO -> Pagina mudar conforme o tempo Manha, Tarde e Noite
// TODO -> Quizz App

class GohanTreinamentos extends StatelessWidget {
  const GohanTreinamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // O sucesso vem como resultado do desenvolvimento de nosso potencial - John Maxwell

  //Luke viu tudo isso e mais: Viu que o conflito era tão necessário para o progresso quanto a harmonia,
  //que o sofrimento era tão essencial para a sabedoria quanto a alegria.
  // Talvez não houvesse pura bondade, nem mal absoluto. Havia apenas vida, apenas mudança e crescimento, sofrimento e alegria...morte e renascimento
  // Havia apenas a Força

  //A prática é fundamental para se tornar um bom desenvolvedor. Portanto, comece com um projeto simples e vá evoluindo gradativamente, sempre implementando novas funcionalidades e explorando novas tecnologias. Boa sorte e bons estudos! - ChatGPT

  // If you want to find secrets of the universe, think in terms of Energy, Frequency and Vibration. - Nikola Tesla

  // É preciso ter o caos dentro de si para gerar uma estrela dançante. Friedrich Nietzsche

  // Não deixe que as pessoas te façam desistir daqui que voce mais quer na vida. Acredite, Lute e Conquiste! - Professor Carvalho

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gohan Treinamentos Version 9 - 13/09/23'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      drawer: DrawerNavigation(),
      //! Código para ter um scroll na minha tela
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          //! Inicio da HomePage
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //! PARTE DE COMUNICAÇÃO
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Flutter Padawan Dia 6 - 17/02/2023'),
                      const Text(
                        'COMO TENTAR ORGANIZAR SUA VIDA!',
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),

                      YoutubeLink(
                          link: 'https://www.youtube.com/watch?v=xFWXl8uLFtk'),

                      //TODO Colocar as frases dentro de uma lista e que seja aleatoria
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Frase do dia: \n"As Pessoas tem que se esforçar e acreditar em si mesmas, assim damos valor a vida porque temos um futuro para viver" \n- Son Goku',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),

                      //TODO Colocar um cronograma de horarios de estudo aqui
                      const Text(
                        'CRONOGRAMA DE HORARIOS',
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TableCustom(
                          columns: const ['HORARIO', 'Tarefas'],
                          rows: const [
                            [
                              '07h- 09h',
                              'Acordar, tomar café, se exercitar e tomar banho para se organizar para estudar'
                            ],
                            [
                              '09h-12h',
                              'Estudar e adquirir conhecimento em algum assunto importante'
                            ],
                            [
                              '13h-15h',
                              'Trabalhar em tarefas difíceis com muita determinação!'
                            ],
                            [
                              '15h-18h',
                              'Buscar soluções criativas no trabalho!'
                            ],
                            [
                              '18h-20h',
                              'Treino e descanso, refletindo seu desempenho durante o dia'
                            ],
                          ],
                        ),
                      ),

                      Row(
                        children: const [
                          SimpleCard(
                              titulo: 'Manha: Planejamento + Leitura',
                              card_color: Colors.blue,
                              items: [
                                ' --> ESTUDES OS CONCEITOS!',
                                '- Seja Criativo',
                                '- Gratidão',
                                '- Escolha uma Rotina -> Calistenia, Livro, Linguagem de Programação',
                                '- Conexão com a Agua e Sol',
                                '- 10 Min Meditação | 10 Min de Sol | 30 min Lendo Livros',
                                ' Vibração Baixa',
                              ]),
                          Text('OBJETIVOS DO DIA:')
                        ],
                      ),
                      const SimpleCard(
                          titulo: 'Tarde: Prática + Coding Devloper Thinking',
                          card_color: Colors.red,
                          items: [
                            ' --> SE CONCENTRE NA PRÁTICA!',
                            '- Determinação',
                            '- Resolução de Problemas',
                            '- Terminar os Projetos e Tasks',
                            '- Alto Foco + Alta Concentração',
                            '- Resolução de Problemas',
                            ' Vibração Alta',
                          ]),
                      const SimpleCard(
                          titulo: 'Noite: Night Wolf + Relaxamento',
                          card_color: Colors.purple,
                          items: [
                            '- Estude e Faça Ciencia acontecer',
                            '- Enteder Ciclos de Vida',
                            '- Justiceiro + Super Hero',
                            '- Treine a sua mente, sua Comunicação com o Universo e Relaxe!',
                          ]),
                      //todo list com checkbox
                      const Text(
                        '5 Tarefas por dia',
                        style: TextStyle(fontSize: 30),
                      ),

                      const SimpleCard(
                          titulo: 'Assistente Virtual',
                          card_color: Colors.yellow,
                          items: [
                            '- Metodos de Scrum',
                            'Organização',
                            'Regra 5/25',
                            '30 Horas! é o segredo',
                            '- Bons Habitos são custo no presente mas com Recompensa no Futuro',
                            '- Maus Habitos tem Custos no Futuro Mas com Recompensa Imediata',
                          ]),
                      const Text(
                          'O segredo da vida: https://www.youtube.com/watch?v=xFWXl8uLFtk'),

                      const Text(
                        'https://www.youtube.com/watch?v=cy7i5B18z-c',
                        textWidthBasis: TextWidthBasis.longestLine,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 26),
                      ),
                    ],
                  ),
                ),

                //!TRANSFORMAR TUDO ISSO EM SEU PRÓPRIO WIDGET
                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Presente:',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          'O presente é o momento atual, agora.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text('Tudo é uma ação'),
                      ],
                    ),
                  ),
                ),
                //!TRANSFORMAR TUDO ISSO EM SEU PROPRIO WIDGET

                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),

                const SizedBox(height: 20),
                const Text(
                  'Passado:',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'O passado é tudo o que já aconteceu.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Futuro:',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'O futuro é tudo o que ainda vai acontecer.',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'O futuro depende do presente',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
