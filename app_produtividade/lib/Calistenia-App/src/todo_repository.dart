import 'package:app_produtividade/Calistenia-App/todo_list_2024.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAll();
  Future<TodoModel> inserir(TodoModel model);
  Future<TodoModel> update(TodoModel model);
  Future<bool> delete(int id);
}

class BancoDeDados implements TodoRepository {
  late var db;

  @override
  Future<List<TodoModel>> getAll() async {
    // Implementar a lógica para obter todos os itens do banco de dados
    return [];
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

void registerInstances() {
  var banco = BancoDeDados();
  final actions = TodoAction();
}
