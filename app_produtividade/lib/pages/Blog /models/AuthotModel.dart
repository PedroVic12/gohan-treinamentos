class Author {
  late String bio;
  late String sId;
  late String name;
  late String title;
  late String badge;
  late String image;

  Author(
      {required this.bio,
      required this.sId,
      required this.name,
      required this.title,
      required this.badge,
      required this.image});

  Author.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    sId = json['_id'];
    name = json['name'];
    title = json['title'];
    badge = json['badge'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio'] = bio;
    data['_id'] = sId;
    data['name'] = name;
    data['title'] = title;
    data['badge'] = badge;
    data['image'] = image;
    return data;
  }
}
