import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:dio/dio.dart';

class FilmesRepository {
  var dio = Dio();

  FilmesRepository() {
    dio.options.headers['X-Parse-Application-Id'] =
        'w6SIj1t1hl5xwehGfNrkcT4mDv1HywGFZ7k4oBRm';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'zPDS4dOgbBsfAiRyQlzXeQ0FE1xgYGjlTBsvPyJQ';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.baseUrl = 'https://parseapi.back4app.com/classes/';
  }

  Future<FilmesModel> obterFilmes() async {
    var result = await dio.get('/Filmes');
    return FilmesModel.fromJson(result.data);
  }

  Future<void> inserir(Tarefa tarefa) async {
    try {
      var response = await dio.post('/Filmes', data: tarefa.toCreateJson());
    } catch (e) {
      print('Erro ao cadastrar filme $e');
    }
  }

  Future<void> atualizar(Tarefa tarefa) async {
    try {
      await dio.put('/Filmes/${tarefa.objectId}', data: tarefa.toCreateJson());
    } catch (e) {
      print('Erro no filme $e');
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await dio.delete('/Filmes/$objectId');
    } catch (e) {
      print('Erro no filme $e');
    }
  }
}
