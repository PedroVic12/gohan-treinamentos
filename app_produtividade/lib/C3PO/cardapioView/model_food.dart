class ProdutoModel {
  String nome;
  String categoria;
  double preco_1;
  String? sub_categoria;
  double? preco_2;
  String? ingredientes;
  String? imagem;

  ProdutoModel({
    required this.nome,
    required this.preco_1,
    required this.categoria,
    this.sub_categoria,
    this.preco_2,
    this.ingredientes,
    this.imagem,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'preco_1': preco_1,
      'preco_2': preco_2,
      'ingredientes': ingredientes,
      'imagem': imagem,
      "sub_categoria": sub_categoria,
    };
  }

  // Factory constructor para converter JSON em um objeto ProdutoModel
  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      nome: json['NOME'],
      categoria: json['CATEGORIA'],
      preco_1: json['preco_1'],
      preco_2: json['preco_2'],
      sub_categoria: json["SUB_CAT"],
      ingredientes: json['IGREDIENTES'],
      imagem: json['IMAGEM'],
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
