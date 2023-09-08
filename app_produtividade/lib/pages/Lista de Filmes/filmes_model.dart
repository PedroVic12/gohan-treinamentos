class FilmesModel {
  List<Tarefa>? results;

  FilmesModel({this.results}); // Removido o parâmetro List list

  FilmesModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Tarefa>[];
      json['results'].forEach((v) {
        results!.add(Tarefa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tarefa {
  String? objectId;
  String? descricao;
  bool? concluido;
  String? createdAt; // Este campo é não-nulo
  String? updatedAt;

  Tarefa({
    this.objectId,
    required this.descricao,
    required this.concluido,
    this.createdAt, // Use "required" para garantir que ele seja sempre fornecido
    this.updatedAt,
  });

  Tarefa.fromJson(Map<String, dynamic> json)
      : createdAt = json[
            'createdAt'], // Inicialize "createdAt" no construtor de inicialização
        objectId = json['objectId'],
        descricao = json["descricao"],
        concluido = json["concluido"],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;

    return data;
  }
}
