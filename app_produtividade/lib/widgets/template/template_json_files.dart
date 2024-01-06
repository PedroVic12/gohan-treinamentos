import 'dart:convert';
import 'dart:io';

import 'package:app_produtividade/template/models.dart';

class RepositoryDataBaseController {
  final String sanduicheTradicionalFile = 'lib/repository/cardapio_1.json';
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';
  final dataBase_Array = [];

  Future<List<ProdutoModel>> lerProdutosDeJson(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData
          .map((jsonItem) => ProdutoModel.fromJson(jsonItem))
          .toList();
    } catch (e) {
      print('Erro ao ler o arquivo JSON: $e');
      return [];
    }
  }

  Future<List> fetchAllProducts() async {
    //await dataBase_Array.add(getHamburguer());

    return dataBase_Array;
  }

  getHamburguer() {
    var results = lerArquivoJson(sanduicheTradicionalFile);
  }

  getPetiscos() {
    var results = lerArquivoJson(petiscosFile);
  }

  lerArquivoJson(String file) {}

  List<ProdutoModel> converterParaModelos(
      List<List<Map<String, dynamic>>> dados) {
    return dados
        .expand((produtoLista) => produtoLista)
        .map((produto) => ProdutoModel.fromJson(produto))
        .toList();
  }

  List<ProdutoModel> filtrarPorCategoria(
      List<ProdutoModel> produtos, String categoria) {
    return produtos.where((produto) => produto.categoria == categoria).toList();
  }

  void ordenarPorNome(List<ProdutoModel> produtos) {
    produtos.sort((a, b) => a.nome.compareTo(b.nome));
  }
}

void main() async {
  final _controller = RepositoryDataBaseController();

  var produtos =
      await _controller.lerProdutosDeJson('lib/template/assets/pizzas.json');

  var pizzas = _controller.filtrarPorCategoria(produtos, "Pizza");

  // Exemplo de uso dos produtos
  for (var produto in produtos) {
    print(
        'Produto: ${produto.nome}, Categoria: ${produto.categoria}, ${produto.precos}  \n');
  }

  _controller.ordenarPorNome(produtos);

  for (var element in pizzas) {
    print(element.nome);
  }
}
