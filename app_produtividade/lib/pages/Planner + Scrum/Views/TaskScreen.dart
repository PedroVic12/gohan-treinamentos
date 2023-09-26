// planner_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/TaskController.dart';

class PlannerScreen extends StatelessWidget {
  final TaskScrumController taskController = Get.put(TaskScrumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planejamento'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Backlog de Tarefas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildTaskList(),
            Divider(),
            Text(
              'Priorização',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildPriorityInput(),
            Divider(),
            Text(
              'Sprint Planning',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildSprintInput(),
            Divider(),
            Text(
              'Definição de Metas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildGoalInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Obx(
      () => Column(
        children: taskController.tasks
            .asMap()
            .entries
            .map(
              (entry) => ListTile(
                title: Text(entry.value.title),
                subtitle: Text(entry.value.description),
                trailing: Text('Prioridade: ${entry.value.priority}'),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPriorityInput() {
    int selectedTaskIndex = 0; // Defina o índice da tarefa selecionada.
    return Row(
      children: [
        DropdownButton<int>(
          value: taskController.tasks[selectedTaskIndex].priority,
          onChanged: (int? value) {
            if (value != null) {
              taskController.prioritizeTask(selectedTaskIndex, value);
            }
          },
          items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>(
            (int priority) {
              return DropdownMenuItem<int>(
                value: priority,
                child: Text('Prioridade $priority'),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildSprintInput() {
    int selectedTaskIndex = 0; // Defina o índice da tarefa selecionada.
    int selectedSprintNumber = 1; // Defina o número da sprint selecionada.
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            taskController.addToSprint(selectedTaskIndex, selectedSprintNumber);
          },
          child: Text('Adicionar à Sprint $selectedSprintNumber'),
        ),
      ],
    );
  }

  Widget _buildGoalInput() {
    int selectedSprintNumber = 1; // Defina o número da sprint selecionada.
    TextEditingController goalController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: goalController,
          decoration: InputDecoration(
            labelText: 'Meta da Sprint $selectedSprintNumber',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final goal = goalController.text;
            taskController.setSprintGoal(selectedSprintNumber, goal);
          },
          child: Text('Definir Meta'),
        ),
      ],
    );
  }
}
