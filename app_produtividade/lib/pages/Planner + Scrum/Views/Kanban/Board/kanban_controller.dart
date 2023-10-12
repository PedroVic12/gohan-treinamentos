// lib/models/task.dart

import 'package:get/get.dart';

class Task {
  String title;

  Task({required this.title});
}

class ColunaKanban {
  final String title;
  final List<Task> tasks;

  ColunaKanban({
    required this.title,
    required this.tasks,
  });
}

class ItemTrabalho {
  final String title;
  late String description;
  late String time;
  late String tipe;

  ItemTrabalho(
      {required this.title,
      this.description = '',
      this.time = '',
      this.tipe = ''});
}
