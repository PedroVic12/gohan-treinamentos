import 'AuthotModel.dart';
import 'meta_model.dart';


class Post {
  late Meta meta;
  late String sId;
  late String title;
  late String summary;
  late Author author;
  late String category;
  late String createDate;

  Post(
      {required this.meta,
         required this.sId,
        required this.title,
        required this.summary,
        required this.author,
        required this.category,
        required this.createDate});

  Post.fromJson(Map<String, dynamic> json) {
    meta = (json['meta'] != null ? new Meta.fromJson(json['meta']) : null)!;
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    author =
    (json['author'] != null ? new Author.fromJson(json['author']) : null)!;
    category = json['category'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['category'] = this.category;
    data['createDate'] = this.createDate;
    return data;
  }
}