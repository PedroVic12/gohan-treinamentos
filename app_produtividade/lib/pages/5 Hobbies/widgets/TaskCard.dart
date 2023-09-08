import 'package:app_produtividade/pages/5%20Hobbies/widgets/SubTaskWidget.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Exemplo de lista de sub tarefas
    final subTasks = [
      {'title': 'Subtarefa 1', 'isChecked': false},
      {'title': 'Subtarefa 2', 'isChecked': true},
      {'title': 'Subtarefa 3', 'isChecked': false},
    ];

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Tarefa Principal'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: subTasks.length,
            itemBuilder: (context, index) {
              final subTask = subTasks[index];
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
