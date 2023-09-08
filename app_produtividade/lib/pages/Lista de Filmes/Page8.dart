import 'package:app_produtividade/pages/Lista%20de%20Filmes/escolher_filme.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_controller.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaDeFilmesPage extends StatefulWidget {
  @override
  _ListaDeFilmesPageState createState() => _ListaDeFilmesPageState();
}

class _ListaDeFilmesPageState extends State<ListaDeFilmesPage> {
  final descricaoController = TextEditingController();
  final FilmesController controller = Get.put(FilmesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lista de Filmes')),
        automaticallyImplyLeading: false,
        actions: [
          Obx(() => Switch(
                value: controller.apenasNaoConcluidos.value,
                onChanged: (value) {
                  setState(() {
                    controller.apenasNaoConcluidos.value = value;
                  });
                },
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.carregando.value) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.filmes.value.results?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var filme = controller.filmes.value.results![index];

                  if (controller.apenasNaoConcluidos.value &&
                      filme.concluido!) {
                    return SizedBox.shrink();
                  }

                  return Dismissible(
                    key: Key(filme.objectId!),
                    onDismissed: (direction) async {
                      await controller.remover(filme.objectId!);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          filme.descricao ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: AutofillHints.language),
                        ),
                        trailing: Checkbox(
                          value: filme.concluido,
                          onChanged: (bool? value) async {
                            filme.concluido = value;
                            await controller.atualizar(filme);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          FilmDisplay(controller: controller),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: RandomFilmButton(controller: controller),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          descricaoController.text = '';
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: Text("Adicionar novo filme"),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        controller.inserir(Tarefa(
                            descricao: descricaoController.text,
                            concluido: false,
                            createdAt: DateTime.now().toIso8601String()));
                        Get.back();
                      },
                      child: Text('Salvar Filme'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancelar'),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
