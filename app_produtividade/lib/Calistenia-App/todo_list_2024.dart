import 'package:app_produtividade/Calistenia-App/src/todo_repository.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final actions = TodoAction();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    actions.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          counter(),
          TodoContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget counter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget TodoContainer() {
    return RxBuilder(builder: (_) {
      final todos = todoState.value;

      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, index) {
          final tarefa = todos[index];
          return CheckboxListTile(
            value: tarefa.check,
            onChanged: (value) {},
            title: Text(tarefa.titulo),
          );
        },
      );
    });
  }
}

class TodoModel {
  final int id;
  final String titulo;
  final bool check;

  TodoModel({
    required this.id,
    required this.titulo,
    required this.check,
  });

  TodoModel copyWith({
    int? id,
    String? titulo,
    bool? check,
  }) {
    return TodoModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      check: check ?? this.check,
    );
  }
}

final todoState = Atom<List<TodoModel>>([]);

class TodoAction {
  var _autoIncrement = 4;

  final repository = Get.put(BancoDeDados());

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
      todoState.value = [
        ...todoState.value,
        model.copyWith(id: _autoIncrement),
      ];
    } else {
      final index = todoState.value.indexWhere((e) => e.id == model.id);
      todoState.value[index] = model;
      todoState.value = todoState.value;
    }
  }

  Future<void> delete(int id) async {
    todoState.value = todoState.value.where((e) => e.id != id).toList();
    await repository.delete(id);
  }
}
