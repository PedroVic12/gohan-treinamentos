import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:dio/dio.dart';

class FilmesRepository {
  Future<FilmesModel> obterFilmes() async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] =
        'w6SIj1t1hl5xwehGfNrkcT4mDv1HywGFZ7k4oBRm';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'zPDS4dOgbBsfAiRyQlzXeQ0FE1xgYGjlTBsvPyJQ';
    dio.options.headers['Content-Type'] = 'application/json';

    var result = await dio.get('https://parseapi.back4app.com/classes/Filmes');
    return FilmesModel.fromJson(result.data);
  }
}
