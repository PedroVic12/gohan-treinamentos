import 'package:app_produtividade/pages/Lista%20de%20Filmes/filmes_model.dart';
import 'package:dio/dio.dart';

class FilmesRepository {
  Future<FilmesModel> obterFilmes() async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] = '';
    dio.options.headers[''] = '';
    dio.options.headers[''] = '';

    var result = await dio.get('');
    return FilmesModel.fromJson(result.data);
  }
}
