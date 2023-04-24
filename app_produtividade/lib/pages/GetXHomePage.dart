import 'package:flutter/material.dart';

class GetxHomePage extends StatelessWidget {
  const GetxHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ola mundo!'),
        actions: [],
      ),
      body: Text('Ola mundo!'),
    );
  }
}
