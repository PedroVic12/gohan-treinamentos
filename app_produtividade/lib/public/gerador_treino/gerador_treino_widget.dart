import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MainComponent extends StatefulWidget {
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  bool isDrawerOpen = false;
  bool quizMode = false;
  String userAnswer = "";
  String feedback = "";
  Map<String, bool> completedItems = {};
  int totalCompleted = 0;
  int totalItems = 0;
  double progress = 0;

  List<Map<String, dynamic>> exercises = [
    {
      "id": 1,
      "name": "Revisão Teórica",
      "items": [
        "Teorema de Thévenin",
        "Análise de malhas",
        "Análise nodal",
        "Leis de Kirchhoff",
        "Conceitos básicos de circuitos"
      ],
    },
    {
      "id": 2,
      "name": "Seleção dos Exercícios",
      "items": [
        "Identificar capítulo do Sadiku",
        "Escolher 25 exercícios variados",
        "Priorizar exercícios combinados"
      ],
    },
    {
      "id": 3,
      "name": "Resolução dos Exercícios",
      "items": [
        "Ler enunciado atentamente",
        "Desenhar circuito",
        "Escolher método adequado",
        "Aplicar método escolhido",
        "Verificar resposta"
      ],
    },
    {
      "id": 4,
      "name": "Análise dos Resultados",
      "items": [
        "Comparar diferentes soluções",
        "Identificar padrões",
        "Analisar dificuldades"
      ],
    }
  ];

  List<int> pullups = [12, 15, 10, 14, 11];
  List<int> flexoes = [25, 30, 28, 32, 27];
  List<String> days = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"];

  double averagePullups = 0;
  double averageFlexoes = 0;

  @override
  void initState() {
    super.initState();
    averagePullups = pullups.reduce((a, b) => a + b) / pullups.length;
    averageFlexoes = flexoes.reduce((a, b) => a + b) / flexoes.length;

    totalItems = exercises.fold(0, (sum, ex) => sum + ex["items"].length);
  }

  void handleCheck(int exerciseId, int itemIndex) {
    setState(() {
      String key = '$exerciseId-$itemIndex';
      completedItems[key] = !(completedItems[key] ?? false);

      totalCompleted = completedItems.values.where((val) => val).length;
      progress = (totalCompleted / totalItems) * 100;
    });
  }

  void toggleQuizMode() {
    setState(() {
      quizMode = !quizMode;
    });
  }

  void checkAnswer() {
    setState(() {
      if (userAnswer == "Correct") {
        feedback = "Correto!";
      } else {
        feedback = "Incorreto!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercícios e Quiz"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => setState(() => isDrawerOpen = !isDrawerOpen),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text("Dashboard")),
            ListTile(title: Text("Exercícios")),
            ListTile(title: Text("Quiz")),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Exercícios Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Exercícios do Dia",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: toggleQuizMode,
                    child:
                        Text(quizMode ? "Voltar aos Exercícios" : "Modo Quiz"),
                  )
                ],
              ),
            ),
            if (quizMode)
              Column(
                children: [
                  Text("Aqui seria uma questão do quiz."),
                  ElevatedButton(
                    onPressed: checkAnswer,
                    child: Text("Verificar Resposta"),
                  ),
                  if (feedback.isNotEmpty) Text(feedback),
                ],
              )
            else
              Column(
                children: exercises.map((exercise) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise["name"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(exercise["items"].length, (index) {
                        String key = '${exercise["id"]}-$index';
                        return CheckboxListTile(
                          title: Text(exercise["items"][index]),
                          value: completedItems[key] ?? false,
                          onChanged: (bool? value) {
                            handleCheck(exercise["id"], index);
                          },
                        );
                      }),
                    ],
                  );
                }).toList(),
              ),

            // Dashboard Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Progresso: ${progress.toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 20),
                  ),
                  LinearProgressIndicator(value: progress / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Completados: $totalCompleted"),
                      Text("Total: $totalItems"),
                    ],
                  ),
                ],
              ),
            ),

            // Graphs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: charts.LineChart(
                      [
                        charts.Series<int, String>(
                          id: 'Pullups',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.green.shadeDefault,
                          domainFn: (int pullup, int index) => days[index],
                          measureFn: (int pullup, _) => pullup,
                          data: pullups,
                        ),
                        charts.Series<int, String>(
                          id: 'Flexões',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.red.shadeDefault,
                          domainFn: (int flexao, int index) => days[index],
                          measureFn: (int flexao, _) => flexao,
                          data: flexoes,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: charts.PieChart(
                      [
                        charts.Series<double, String>(
                          id: 'Média',
                          domainFn: (double value, _) => value == averagePullups
                              ? 'Média Pull-ups'
                              : 'Média Flexões',
                          measureFn: (double value, _) => value,
                          data: [averagePullups, averageFlexoes],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
