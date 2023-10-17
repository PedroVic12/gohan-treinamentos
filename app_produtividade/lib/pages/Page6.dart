import 'package:app_produtividade/pages/Pomodoro%20Timer/models/TimerModel.dart';
import 'package:app_produtividade/pages/Pomodoro%20Timer/views/ProductivityButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_produtividade/pages/Pomodoro%20Timer/CountDownTimer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



//!Paramos na Pagina 93

class Page6 extends StatelessWidget {
  //chamando o metodo startWork do meu relogio
  final CountDownTimer meuTimer = CountDownTimer();

  Page6({super.key});

  void onPressed() {
    print('Clicou no botao');
  }

  @override
  Widget build(BuildContext context) {
    // Criando um Contexto dentro do Build
    meuTimer
        .startWork(); // chama o método startWork() na variável membro da classe

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Rel´gio Pomodoro'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;
        final double availableHeight = constraints.maxHeight;

        return Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: ProductivityButton(
                      color: Colors.green,
                      text: 'Trabalhar!',
                      textSize: 20,
                      onPressed: onPressed,
                      size: 35),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: ProductivityButton(
                      color: Colors.red,
                      text: 'Short Break!',
                      textSize: 20,
                      onPressed: onPressed,
                      size: 35),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: ProductivityButton(
                      color: Colors.grey,
                      text: 'Long Break!',
                      textSize: 20,
                      onPressed: onPressed,
                      size: 35),
                )
              ],
            ),
            //! StreamBuilder serve para atualizar o meu timer

            //*
            //A interrogaçãoé usada em uma expressão ternária, que é uma forma abreviada de escrever um if-else. Nesse caso, a expressão snapshot.data == '00:00' é usada para verificar se o valor atual do fluxo é igual a '00:00'. Se for, a variável meuTimer é inicializada com um novo objeto TimerModel contendo o valor '00:00' e uma porcentagem de 1. Se não, a variável meuTimer é inicializada com o valor atual do fluxo.
            //*//
            StreamBuilder<Object>(
                initialData: '00:00',
                stream: meuTimer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel meuTimer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;

                  //! Percentual do meu timer
                  return Expanded(
                      child: CircularPercentIndicator(
                    radius: 200,
                    lineWidth: 15,
                    percent: meuTimer.percent,
                    center: Text(
                      meuTimer.time,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    progressColor: Colors.indigo,
                  ));
                }),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                    child: ProductivityButton(
                        color: Colors.black,
                        text: 'Stop',
                        textSize: 25,
                        onPressed: onPressed,
                        size: 25)),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                    child: ProductivityButton(
                        color: Colors.black,
                        text: 'Restart',
                        textSize: 25,
                        onPressed: onPressed,
                        size: 25))
              ],
            ),
          ],
        );
      }),
    );
  }
}
