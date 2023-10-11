import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kanban_column.dart';
import 'kanban_controller.dart';

class KanbanBoard extends StatelessWidget {
  final KanbanController _kanbanController = Get.put(KanbanController());

  final List<Color> columnColors = [
    Colors.lightBlue.shade100,
    Colors.lightGreen.shade100,
    Colors.red.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Row(
        children: [
          _buildKanbanColumn(
              'Backlog', _kanbanController.backlog, columnColors[0]),
          _buildKanbanColumn(
              'In Progress', _kanbanController.inProgress, columnColors[1]),
          _buildKanbanColumn('Done', _kanbanController.done, columnColors[2]),
        ],
      ),
    );
  }

  Widget _buildKanbanColumn(String title, RxList<Task> tasks, Color color) {
    return KanbanColumn(
      title: title,
      tasks: tasks,
      color: color,
      onTaskDropped: (Task task) {
        _kanbanController.moveTask(task, _kanbanController.backlog, tasks);
      },
    );
  }
}
