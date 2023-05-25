import 'package:app_produtividade/pages/Blog%20/BlogDetailsPage.dart';
import 'package:app_produtividade/pages/Blog%20/Repository/PostRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/PostModel.dart';

class MeuBlogPage extends StatelessWidget {

  var repository = new PostRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gohan Treinamentos'),
      ),
      body: FutureBuilder(
        future: repository.getAll(),
        builder: (ctx,snp){
          if (snp.hasData){

            List? posts = snp.data;
           return ListView.builder(itemCount: posts!.length,itemBuilder: (ctx,i){
             return ListTile(
               title: Text(posts[i]?.title),
               subtitle: Text(posts[i].author.name),
               onTap: (){
                 Get.to(() => BlogDetailsPage(tag: posts[i].meta.url));
               },
             );
           });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}
