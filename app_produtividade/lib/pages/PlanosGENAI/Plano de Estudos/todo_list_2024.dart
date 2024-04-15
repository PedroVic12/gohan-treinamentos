import 'package:app_produtividade/Calistenia-App/src/todo_repository.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, Color> categoryColors = {
  "Faculdade": Colors.blue,
  "Estagio": Colors.green,
  "Projetos": Colors.orange,
  "Freelancer": Colors.red,
};

class TodoList2024 extends StatelessWidget {
  final TodoAction controller = Get.put(TodoAction());

  @override
  Widget build(BuildContext context) {
    controller.fetchTodos();
    registerInstances();

    return Scaffold(
      appBar: AppBar(
        title: Text("Plano de estudos"),
      ),
      body: ListView(
        children: [
          CustomText(
              text:
                  "Você tem ${controller.todoState.length} tarefas pendentes"),
          todoContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementar a lógica para adicionar uma nova tarefa
          controller.todoDialog();
        },
        tooltip: 'Add Tarefas',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget todoContainer() {
    return Container(
      child: Obx(() {
        final todos = controller.todoState;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (_, index) {
            final tarefa = todos[index];
            return Card(
              child: CheckboxListTile(
                value: tarefa.check,
                onChanged: (value) {
                  // Implementar a lógica para marcar/desmarcar uma tarefa
                },
                title: Text(
                  tarefa.titulo,
                  style: TextStyle(
                    color: categoryColors[tarefa.category] ?? Colors.black,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class TodoModel {
  final int id;
  final String titulo;
  final bool check;
  final String category;

  TodoModel({
    required this.id,
    required this.titulo,
    required this.check,
    required this.category,
  });

  TodoModel copyWith({
    int? id,
    String? titulo,
    bool? check,
    String? category,
  }) {
    return TodoModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      check: check ?? this.check,
      category: category ?? this.category,
    );
  }
}

class TodoAction {
  var _autoIncrement = 4;

  final repository = Get.put(BancoDeDados());
  final todoState = RxList<TodoModel>();

  Future<void> fetchTodos() async {
    todoState.value = await repository.getAll();
  }

  Future<void> putTodo(TodoModel model) async {
    if (model.id == -1) {
      await repository.inserir(model);
    } else {
      await repository.update(model);
    }

    fetchTodos();
  }

  void add(TodoModel model) {
    if (model.id == -1) {
      _autoIncrement++;
      todoState.add(model.copyWith(id: _autoIncrement));
    } else {
      final index = todoState.indexWhere((e) => e.id == model.id);
      todoState[index] = model;
    }
  }

  Future<void> delete(int id) async {
    todoState.removeWhere((e) => e.id == id);
    await repository.delete(id);
  }

  void todoDialog([TodoModel? model]) {
    var selecionado;

    model ??=
        TodoModel(id: -1, titulo: "", check: false, category: "Faculdade");
    Get.dialog(
      AlertDialog(
        title: Text("Adicionar tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: model.titulo),
              onChanged: (value) {
                model = model!.copyWith(titulo: value);
              },
              decoration: InputDecoration(hintText: "Título"),
            ),
            const Text("Categoria: "),

            Row(children: [
              TextButton(
                  onPressed: () {
                    selecionado = categoryColors[0].toString();
                    model = model!.copyWith(category: "Faculdade");

                    putTodo(model!);
                  },
                  child: Text(categoryColors[0].toString())),
              TextButton(
                  onPressed: () {}, child: Text(categoryColors[1].toString())),
              TextButton(
                  onPressed: () {}, child: Text(categoryColors[2].toString())),
            ]), //
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              putTodo(model!);
              Get.back();
            },
            child: Text("Salvar"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
