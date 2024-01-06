class ProdutoModel {
  String nome;
  List<Map<String, dynamic>> precos;
  List<String>? ingredientes;
  String? imagem;
  String categoria;

  ProdutoModel({
    required this.nome,
    required this.precos,
    this.ingredientes,
    this.imagem,
    required this.categoria,
  });

  // Factory constructor para converter JSON em um objeto ProdutoModel
  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      nome: json['nome'],
      categoria: json['categoria'],
      precos: _extrairPrecos(json),
      ingredientes: json['ingredientes']?.cast<String>(),
      imagem: json['imagem'],
    );
  }

  // Função privada para extrair preços de um JSON
  static List<Map<String, dynamic>> _extrairPrecos(Map<String, dynamic> json) {
    var precos = <Map<String, dynamic>>[];
    json['precos']?.forEach((preco) {
      precos.add({
        'preco': preco['preco_1'] ?? 0.0,
        'descricao': preco['descricao'] ?? '',
      });
    });
    return precos;
  }
}
