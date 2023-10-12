import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kanban_column.dart';
import 'kanban_controller.dart';

class KanbanBoard extends StatelessWidget {
  final KanbanController _kanbanController = Get.put(KanbanController());

  final List<Color> coresColunas = [
    Colors.blue.shade400,
    Colors.red.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Row(
        children: [
          _buildKanbanColumn('Backlog', _kanbanController.columns['backlog']!,
              coresColunas[0], 0),
          _buildKanbanColumn(
              'TODO', _kanbanController.columns['todo']!, coresColunas[1], 1),
          _buildKanbanColumn('In Progress',
              _kanbanController.columns['inProgress']!, coresColunas[2], 2),
          _buildKanbanColumn('CONCLUIDO!', _kanbanController.columns['done']!,
              coresColunas[3], 3),
        ],
      ),
    );
  }

  Widget _buildKanbanColumn(
      String title, List<ItemTrabalho> tasks, Color color, int index) {
    return KanbanColumn(
      title: title,
      tasks: tasks,
      color: color,
      index: index,
    );
  }
}
