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
