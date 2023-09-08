import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_repository.dart';
import 'package:get/get.dart';

class FilmesController extends GetxController {
  final FilmesRepository _repository = FilmesRepository();
  var filmes = FilmesModel().obs;
  var carregando = false.obs;

  @override
  void onInit() {
    super.onInit();
    carregarFilmes();
  }

  void carregarFilmes() async {
    carregando.value = true;
    filmes.value = await _repository.obterFilmes();
    carregando.value = false;
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
