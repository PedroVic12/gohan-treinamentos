import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

class TaskView extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());

  _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    Get.defaultDialog(
      title: 'Adicionar Tarefa',
      content: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: 'Tarefa'),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                _taskController.addTask(taskController.text);
                Get.back(); // Feche a caixa de diálogo após adicionar a tarefa.
                Get.snackbar('Tarefa adicionada',
                    'A tarefa foi adicionada com sucesso.');
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Container(
            child: Obx(() {
              final tasks = _taskController.taskList;
              return Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      child: ListTile(
                        title: Text(task.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _taskController.removeTask(task);
                            Get.snackbar('Tarefa removida',
                                'A tarefa foi removida com sucesso.');
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskDialog(
                context); // Abra a caixa de diálogo ao pressionar o botão.
          },
          child: CircleAvatar(child: Icon(Icons.add))),
    );
  }
}
