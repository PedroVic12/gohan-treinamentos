import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaDeFilmesPage extends StatefulWidget {
  const ListaDeFilmesPage({super.key});

  @override
  State<ListaDeFilmesPage> createState() => _ListaDeFilmesPageState();
}

class _ListaDeFilmesPageState extends State<ListaDeFilmesPage> {
  FilmesRepository filmesRepository = FilmesRepository();
  var _filmes = FilmesModel();
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  void getAllFilmes() async {
    _filmes = await filmesRepository.obterFilmes();
    setState(() {});
  }

  void salvarFilme() {
    // Implemente o método para salvar o filme aqui
    // Depois de salvar, chame getAllFilmes novamente para atualizar a lista
    getAllFilmes();
    Get.back(); // Fecha o AlertDialog
  }

  @override
  void initState() {
    super.initState();
    getAllFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Filmes'),
        actions: [
          Switch(
            value: apenasNaoConcluidos,
            onChanged: (value) {
              setState(() {
                apenasNaoConcluidos = value;
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _filmes.results?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var filme = _filmes.results![index];

          if (apenasNaoConcluidos && filme.concluido!) {
            return SizedBox
                .shrink(); // Não mostra o item se o filtro estiver ativo e a tarefa estiver concluída
          }

          return Dismissible(
            key: Key(filme.objectId!),
            onDismissed: (direction) {
              // Implementar a lógica para remover o filme da lista e do banco de dados
              _filmes.results!.removeAt(index);
              setState(() {});
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
                onChanged: (bool? value) {
                  setState(() {
                    filme.concluido = value;
                  });
                  // Implementar lógica para atualizar o status no banco de dados
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
                        onPressed: salvarFilme, child: Text('Salvar Filme')),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancelar'))
                  ],
                );
              });
        },
      ),
    );
  }
}
