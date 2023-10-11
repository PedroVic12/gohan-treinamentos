
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/Board/kanban_controller.dart';
import 'package:flutter/material.dart';

class KanbanColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Function(Task) onTaskDropped;
  final Color color;

  KanbanColumn({
    required this.title,
    required this.tasks,
    required this.onTaskDropped,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: DragTarget<Task>(
                onAccept: (Task task) {
                  onTaskDropped(task);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task moved to $title'),
                    ),
                  );
                },
                builder: (context, acceptedTasks, rejectedTasks) => ListView(
                  children:
                      tasks.map((task) => _buildDraggableTask(task)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableTask(Task task) {
    return LongPressDraggable<Task>(
      data: task,
      feedback: Material(
        type: MaterialType.transparency,
        child: Card(
          child: ListTile(
            title: Text(task.title),
          ),
        ),
      ),
      childWhenDragging: Container(),
      child: Card(
        child: ListTile(title: Text(task.title)),
      ),
    );
  }
}