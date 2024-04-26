import 'package:app_produtividade/pages/TodoList%20Interativa/repository.dart';
import 'package:app_produtividade/pages/TodoList%20Interativa/todo_list_controller_2024.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Custom/CustomText.dart';

class TodoListWidget extends StatefulWidget {
  TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final controller = Get.put(TodoListController());
  var repository = TodoListRepository();

  _TodoListWidgetState() {
    controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo list 2024")),
      body: Container(
          child: ListView.builder(
        itemCount: controller.repository.items.length,
        itemBuilder: (context, index) {
          var todo = controller.repository.items[index];
          return Dismissible(
            key: Key(todo.titulo),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                controller.delete(index);
              });
            },
            child: Card(
              color: Colors.yellow,
              child: CheckboxListTile(
                  title: Text(todo.titulo),
                  subtitle:
                      CustomText(text: todo.categoria, color: Colors.green),
                  value: todo.completed,
                  onChanged: (value) {
                    print("${todo.titulo} - ${todo.completed}");
                    setState(() {
                      todo.completed = value!;
                    });
                  }),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.showCadastroDialog(context);
          });
        },
        tooltip: 'New TODO',
        child: const Icon(Icons.add),
      ),
    );
  }
}
