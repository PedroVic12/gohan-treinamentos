import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/controllers/TodoController.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListViewPage.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoScreen.dart';

//packages
import 'package:http/http.dart' as http;

//! Tela onde mostra as listas

class TodoListPage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Todo List com Getx')),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_box_rounded),
          onPressed: () {
            Get.to(TodoScreen());
          }),
      body: SafeArea(
        child: ListView(
          children: [
            //! Itens para Exibir
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,

                // Obx para observar a lista
                child: Obx(() => ListView.separated(
                      itemBuilder: (context, index) {
                        TextStyle textStyle;

                        //Se eu marcar como completa vai ficar vermelho
                        if (todoController.todoItens[index].done) {
                          // ignore: prefer_const_constructors
                          textStyle = TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 50,
                          );

                          // O padrão é estar na cor normal do aplicativo
                        } else {
                          textStyle = TextStyle(
                            fontSize: 25,
                            color:
                                //Null Check para a cor! IDE que mostrou
                                Theme.of(context).textTheme.bodyLarge?.color,
                          );
                        }

                        // Widget dismissible para remover a lista ao deslizar
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (_) {
                            var removed = todoController.todoItens[index];
                            todoController.todoItens.removeAt(index);
                            Get.snackbar(
                              backgroundColor: Colors.black38,
                              'Tarefa Removida',
                              'A Tarefa ${removed.texto} foi removida com sucesso}',
                              mainButton: TextButton(
                                onPressed: () {
                                  if (removed == null) {
                                    return;
                                  }

                                  todoController.todoItens
                                      .insert(index, removed);

                                  if (Get.isSnackbarOpen) {
                                    Get.back();
                                  }
                                },
                                child: const Text(
                                  'Desfazer',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          //Preenchendo a lista a a partir da minha classe Controller
                          child: ListTile(
                            trailing: const Icon(Icons.chevron_right),

                            //?Texto da minha lista
                            title: Text(todoController.todoItens[index].texto,
                                style: textStyle),

                            //Meu checkbox da lista
                            leading: Checkbox(
                              value: todoController.todoItens[index].done,

                              //Logica de mudança de estado do checkbox
                              onChanged: (valor) {
                                //Criando a variavel
                                var changed = todoController.todoItens[index];
                                //null check se o valor é vazio
                                changed.done = valor!;

                                //se tiver tudo certo ele vai mudar
                                todoController.todoItens[index] = changed;
                              },
                            ),

                            onTap: () {
                              Get.to(TodoScreen(
                                index: index,
                              ));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: todoController.todoItens.length,
                    )),
              ),
            ),
            SafeArea(
              child: ElevatedButton(
                onPressed: () async {
                  // fazer a chamada à API
                  final response = await http.post(
                    Uri.parse('http://localhost:8000/todos'),
                    //body: json.encode({'texto': textEditingController.text}),
                    headers: {'Content-Type': 'application/json'},
                  );
                  if (response.statusCode == 200) {
                    // atualizar a lista de itens
                    todoController.update();
                    Get.back();
                  } else {
                    // tratar erro
                    print('Erro ao salvar item: ${response.statusCode}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // foreground
                ),
                child: const Text('Adicionar um item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
