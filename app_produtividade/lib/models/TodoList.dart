class TodoList {
  String texto = '';
  bool done = false;
  List<String> subTitulo = [];

  TodoList({
    required this.texto,
    this.done = false,
    required this.subTitulo,
  });

  //! Métodos buscando de um Json
  TodoList.fromJson(Map<String, dynamic> json) {
    //Tratamentos par ao Null Safety
    if (json['texto'] != null) {
      texto = json['texto'];
    } else {
      texto = '';
    }

    if (json['done'] != null) {
      done = json['done'];
    } else {
      done = false;
    }
  }

  //map to Json
  Map<String, dynamic> toJson() => {
        'texto': texto,
        'done': done,
      };

  //! Métodos usando o Map
  //método para converter o objeto em um Map
  Map<String, dynamic> toMap() {
    return {
      'texto': texto,
      'done': done,
    };
  }

  //método para converter um Map em um objeto
  factory TodoList.fromMap(Map<String, dynamic> map) {
    return TodoList(
      texto: map['texto'] ?? '',
      done: map['done'] ?? false,
      subTitulo: map.containsKey('subTitulo')
          ? List<String>.from(map['subTitulo'])
          : [],
    );
  }
}
