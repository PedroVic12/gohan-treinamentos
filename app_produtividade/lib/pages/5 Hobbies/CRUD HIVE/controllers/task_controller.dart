import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart'; // Importe a classe Task.

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;
  late Box<Task> taskBox;

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  Future<void> saveAndPrintData() async {
    final taskBox = Hive.box<Task>('tasks');
    final tasks = taskBox.values.toList();

    // Imprimir os dados no console
    for (var task in tasks) {
      print('Tarefa: ${task.title}');
    }

    // Salvar os dados em um arquivo JSON
    try {
      final jsonData = jsonEncode(tasks);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tasks.json');
      await file.writeAsString(jsonData);
      print('Dados salvos em ${file.path}');
    } catch (e) {
      print('nao foi possivel salvar os dados $e');
    }
  }


  void _loadTasks() {
    taskBox = Hive.box<Task>('tasks');
    taskList.assignAll(taskBox.values.toList());
  }

  void addTask(String title) {
    final task = Task(title ); // Forneça a descrição aqui.
    taskBox.add(task);
    taskList.add(task);

    saveAndPrintData();
  }

  void removeTask(Task task) {
    taskBox.delete(task.key);
    taskList.remove(task);
  }

  void updateTask(Task task) {
    taskBox.put(task.key, task);
  }
}
