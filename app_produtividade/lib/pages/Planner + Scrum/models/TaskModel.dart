// task_model.dart

class TaskModel {
  final String title;
  final String description;
  int priority;

  TaskModel({
    required this.title,
    required this.description,
    this.priority = 1,
  });
}
