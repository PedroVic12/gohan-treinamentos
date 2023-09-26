import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/controllers/TodoController.dart';
import 'package:app_produtividade/models/TodoList.dart';

//! Todo list padrão
class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();

/*
 Com o Null Safety, é possível declarar explicitamente se uma variável ou parâmetro pode ser nulo ou não, 
 evitando assim referências nulas em tempo de execução.
 O sistema de tipos agora inclui informações adicionais que ajudam a garantir a segurança nula e a evitar
 a necessidade de lidar com nulls.

 As vantagens do Null Safety são muitas, como a redução de erros de tempo de execução,
 um código mais claro e fácil de entender, e um aumento na produtividade do desenvolvedor,
 pois o compilador pode detectar erros de referência nula em tempo de compilação, 
 em vez de ter que esperar pelo tempo de execução. O Null Safety também torna o código mais confiável, 
 seguro e fácil de manter, pois os desenvolvedores não precisam mais lidar com referências nulas em todo o código.

Em resumo, o Null Safety é uma ferramenta importante que torna o Dart mais seguro e fácil de usar, 
ajudando os desenvolvedores a escrever códigos mais confiáveis e seguros.
 */

  // Usando o null Safety para o Index
  final int? index;
  TodoScreen({Key? key, this.index = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = 'Teste de Texto'; // inicializando com uma string vazia
    if (index == null) {
      TextEditingController textEditingController =
          TextEditingController(text: text);
    }

    TextEditingController textEditingController =
        TextEditingController(text: text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Todo List'),
      ),
      backgroundColor: const Color.fromARGB(255, 199, 199, 199),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Digite a tarefa que deseja completar',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (index == null) {
                        String newText = textEditingController.text.trim();
                        if (newText.isNotEmpty) {
                          todoController.todoItens
                              .add(TodoList(texto: newText, subTitulo: []));
                        }
                      } else if (index! < todoController.todoItens.length) {
                        var editing = todoController.todoItens[index!];
                        editing.texto = textEditingController.text;
                        todoController.todoItens[index!] = editing;
                      }

                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // foreground
                    ),
                    child:
                        Text((index == null) ? 'Adicionar' : 'Editar a tarefa'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
