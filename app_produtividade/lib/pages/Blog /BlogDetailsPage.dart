import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'Repository/PostRepository.dart';

class BlogDetailsPage extends StatelessWidget {
  final String tag;
  final repoistory = new PostRepository();

  BlogDetailsPage({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: FutureBuilder(
        future: repoistory.getPostBody(tag),
        builder: (ctx,snp) {
          if (snp.hasData) {
            String? data = snp.data;
            return Markdown(data: data!, styleSheet: MarkdownStyleSheet(
              h2: TextStyle(
                color: Colors.red,
                fontSize: 22
              )
            ),);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}
