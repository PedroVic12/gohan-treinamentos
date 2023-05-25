//TODO 16:34
import 'package:app_produtividade/pages/Blog%20/models/PostModel.dart';
import 'package:dio/dio.dart';

class PostRepository {
  Future<List> getAll() async {
    var url = 'https://api.balta.io/v1/posts'; // change here, criar um método de posts
    Response response = await Dio().get(url);
    return (response.data as List).map((post)=> Post.fromJson(post)).toList();
  }

  Future <String> getPostBody(tag) async {
    //TODO try catch aqui
      Response response = await Dio().get("https://raw.githubuser.com/PedroVic12/gohan-treinamentos/master/${tag}.md");
      return response.data;
  }
}