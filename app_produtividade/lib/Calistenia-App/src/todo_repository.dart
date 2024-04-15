import 'package:app_produtividade/pages/PlanosGENAI/Plano%20de%20Estudos/todo_list_2024.dart';
import 'package:get/get.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAll();
  Future<TodoModel> inserir(TodoModel model);
  Future<TodoModel> update(TodoModel model);
  Future<bool> delete(int id);
}

class BancoDeDados implements TodoRepository {
  late var db;

  List<TodoModel> arrayTodo = [];

  @override
  Future<List<TodoModel>> getAll() async {
    // Implementar a lógica para obter todos os itens do banco de dados

    arrayTodo.add(
      TodoModel(id: 1, titulo: "titulo", check: false, category: "Projetos"),
    );

    return arrayTodo;
  }

  @override
  Future<TodoModel> inserir(TodoModel model) async {
    // Implementar a lógica para inserir um item no banco de dados
    return model;
  }

  @override
  Future<TodoModel> update(TodoModel model) async {
    // Implementar a lógica para atualizar um item no banco de dados
    return model;
  }

  @override
  Future<bool> delete(int id) async {
    // Implementar a lógica para excluir um item do banco de dados
    return true;
  }
}

class TodoController extends GetxController {
  var todoState = RxList<TodoModel>([]);

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
      final autoIncrement = todoState.isNotEmpty ? todoState.last.id + 1 : 1;
      todoState.add(model.copyWith(id: autoIncrement));
    } else {
      final index = todoState.indexWhere((e) => e.id == model.id);
      todoState[index] = model;
    }
  }

  Future<void> delete(int id) async {
    todoState.removeWhere((e) => e.id == id);
    await repository.delete(id);
  }
}

void registerInstances() {
  final todoController = Get.put(TodoController());
}
