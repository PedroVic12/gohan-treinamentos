import 'package:app_produtividade/pages/QuizzPage/controllers/quizz_controller.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  @override
  Widget build(BuildContext context) {
    final controller = QuizzController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Quizz Page',
              ),
              CustomText(text: "Quantidade de perguntas 1/10"),
              CustomText(text: "Score ${controller.score}"),
            ],
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                controller.questions[controller.currentQuestionIndex],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Column(children: [
                IconButton(
                    onPressed: () {
                      controller.checkAnswer("Verdadeiro");
                    },
                    icon: Icon(Icons.check_circle_outline)),
                Text("Verdadeiro"),
              ]),
              Column(children: [
                IconButton(
                    onPressed: () {
                      controller.checkAnswer("Falso");
                    },
                    icon: Icon(Icons.cancel_outlined)),
                Text("Falso"),
              ]),
            ],
          )
        ],
      )),
    );
  }
}
