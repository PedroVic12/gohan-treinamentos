import 'package:flutter/material.dart';

class NightWolfAppBar extends StatelessWidget {
  const NightWolfAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🐺 -> NIGHT WOLF 1 - TodoList🐺'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ), //IconButton
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.black,
        elevation: 50.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {
            //coloque aqui a função que você quer que seja executada ao clicar no botão
            // coloque aqui uma messageBox verde
          },
        ), //IconButton
      ),
    );
  }
}

