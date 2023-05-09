class Meta {
  late String titulo;
  late String descricao;
  late String url;

  Meta({required this.titulo, required this.descricao, required this.url});

  Meta.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descricao = json['descricao'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    data['url'] = url;
    return data;
  }
}
