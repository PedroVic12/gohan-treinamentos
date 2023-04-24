import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gohan_treinamentos_app/models/TodoList.dart';

class TodoController extends GetxController {
  var todoItens = <TodoList>[].obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('TODO Itens');

    if (storedTodos != null) {
      todoItens.assignAll(storedTodos.map((todo) => TodoList.fromMap(todo)));
    }

    ever(todoItens, (_) {
      GetStorage().write('TODO Itens', todoItens.toList());
    });

    super.onInit();
  }
}
