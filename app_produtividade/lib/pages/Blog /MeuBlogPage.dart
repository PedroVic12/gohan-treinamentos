import 'package:flutter/material.dart';

class MeuBlogPage extends StatelessWidget {
  const MeuBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gohan Treinamentos'),
      ),
      body: Center(
        child: Text('Meu Blog'),
      ),
    );
  }
}
