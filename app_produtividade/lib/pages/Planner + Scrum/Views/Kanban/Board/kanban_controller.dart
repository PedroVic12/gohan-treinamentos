// lib/models/task.dart

import 'package:get/get.dart';

class Task {
  String title;

  Task({required this.title});
}

class KanbanController extends GetxController {
  RxList<Task> backlog = <Task>[].obs;
  RxList<Task> inProgress = <Task>[].obs;
  RxList<Task> done = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    backlog.add(Task(title: 'Example Task'));
  }

  void moveTask(Task task, RxList<Task> oldColumn, RxList<Task> newColumn) {
    oldColumn.remove(task);
    newColumn.add(task);
  }
}
