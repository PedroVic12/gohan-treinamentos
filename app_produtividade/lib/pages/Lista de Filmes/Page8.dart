import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_controller.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaDeFilmesPage extends StatelessWidget {
  final descricaoController = TextEditingController();
  final apenasNaoConcluidos = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilmesController>(
      init: FilmesController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lista de Filmes'),
            actions: [
              Obx(() => Switch(
                    value: apenasNaoConcluidos.value,
                    onChanged: (value) {
                      apenasNaoConcluidos.value = value;
                    },
                  ))
            ],
          ),
          body: controller.carregando.value
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.filmes.value.results?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var filme = controller.filmes.value.results![index];

                    if (apenasNaoConcluidos.value && filme.concluido!) {
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
                      child: ListTile(
                        title: Text(filme.descricao ?? ''),
                        trailing: Checkbox(
                          value: filme.concluido,
                          onChanged: (bool? value) async {
                            filme.concluido = value;
                            await controller.atualizar(filme);
                          },
                        ),
                      ),
                    );
                  },
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
      },
    );
  }
}
