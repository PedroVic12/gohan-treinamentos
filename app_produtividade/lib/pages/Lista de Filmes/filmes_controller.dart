import 'dart:math';

import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_repository.dart';
import 'package:get/get.dart';

class FilmesController extends GetxController {
  final FilmesRepository _repository = FilmesRepository();
  var filmes = FilmesModel().obs;
  var carregando = false.obs;
  var apenasNaoConcluidos = false.obs;

  @override
  void onInit() {
    super.onInit();
    carregarFilmes();
  }

  var currentDisplay = ''.obs;

  void selectRandomFilm() {
    if (filmes.value.results != null && filmes.value.results!.isNotEmpty) {
      int randomIndex = Random().nextInt(filmes.value.results!.length);
      Tarefa randomFilm = filmes.value.results![randomIndex];
      currentDisplay.value = randomFilm.descricao ?? 'Filme sem descrição';
    } else {
      currentDisplay.value = 'Nenhum filme disponível';
    }
  }

  void carregarFilmes() async {
    carregando.value = true;
    filmes.value = await _repository.obterFilmes();
    carregando.value = false;
    update(); // Adicione isso
  }

  Future<void> inserir(Tarefa tarefa) async {
    await _repository.inserir(tarefa);
    carregarFilmes();
  }

  Future<void> atualizar(Tarefa tarefa) async {
    await _repository.atualizar(tarefa);
    carregarFilmes();
  }

  Future<void> remover(String objectId) async {
    await _repository.remover(objectId);
    carregarFilmes();
  }
}
