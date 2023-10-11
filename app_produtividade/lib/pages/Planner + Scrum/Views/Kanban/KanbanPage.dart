import 'package:boardview/board_item.dart';
import 'package:camorim/widgets/QuadroKanban.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

import '../widgets/boardview.dart';

class KanbanPage extends StatelessWidget {
  const KanbanPage({Key? key}) : super(key: key);

  final cor1 = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [],
          title: Text('AppBar'),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: Container(height: 1.0, color: Colors.grey))),
      body: ListView(children: [
        Row(
          children: [
            Icon(
              Icons.view_column,
              color: cor1,
            ),
            SizedBox(
              width: 20,
            ),
            Text('Pedidos')
          ],
        ),
        //BoardViewWidget()
      ]),
    );
  }
}
