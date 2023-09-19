import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var counter = List<int>.generate(5, (index) => 0).obs;

  void increment(int cardId) {
    if (cardId >= 0 && cardId < counter.length) {
      counter[cardId]++;
    }
  }

  void resetCounters() {
    for (int i = 0; i < counter.length; i++) {
      counter[i] = 0;
    }
  }
}

class ContadorPage extends StatelessWidget {
  final controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incrementador com GetX e MVC'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.resetCounters();
            },
            tooltip: 'Resetar Contadores',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ContadorView(controller: controller, cardId: index);
                },
              ),
            ),
            Obx(() => Container(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'Desempenho da semana: ${controller.counter.fold(0, (sum, value) => sum + value)}/35',
                        style: TextStyle(fontSize: 20),
                      ),
                      LinearProgressIndicator(
                        value: controller.counter
                                .fold(0, (sum, value) => sum + value) /
                            35,
                        color: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        backgroundColor: Colors.grey[200],
                      )
                    ],
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}

class ContadorView extends StatelessWidget {
  final CounterController controller;
  final int cardId;

  ContadorView({required this.controller, required this.cardId, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adiciona sombra ao card
      margin: EdgeInsets.all(16), // Margem ao redor do card
      child: ListTile(
        leading: CircleAvatar(child: Text('$cardId')),
        title: Text('Contagem'),
        subtitle: Text('Description'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
                  '${controller.counter[cardId]}',
                  style: TextStyle(fontSize: 24),
                )),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                controller.increment(cardId);
              },
              tooltip: 'Incrementar Contador',
            ),
          ],
        ),
      ),
    );
  }
}
