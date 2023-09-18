class Hobby {
  String title;
  String description;
  int count;

  Hobby({
    required this.title,
    required this.description,
    this.count = 0,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      title: json['title'],
      description: json['description'],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'count': count,
    };
  }
}

class MeuHobby {
  String? title;
  List<String>? description;
  late int count;

  MeuHobby({
    required this.title,
    required this.description,
    this.count = 0,
  });

  MeuHobby.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
