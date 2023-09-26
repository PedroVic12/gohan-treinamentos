// task_controller.dart
import 'package:app_produtividade/pages/Planner%20+%20Scrum/models/TaskModel.dart';
import 'package:get/get.dart';

class TaskScrumController extends GetxController {
  var tasks = <TaskModel>[].obs;

  void addTask(TaskModel task) {
    tasks.add(task);
  }

  void prioritizeTask(int index, int priority) {
    tasks[index].priority = priority;
  }

  void addToSprint(int index, int sprintNumber) {
    // Implemente a lógica para adicionar à sprint
  }

  void setSprintGoal(int sprintNumber, String goal) {
    // Implemente a lógica para definir a meta da sprint
  }
}
