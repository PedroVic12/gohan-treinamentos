import 'package:app_produtividade/pages/Notes%20App/views/DrawingPage.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final Function()? onTap;
  final Map doc;
  const NoteCard({Key? key, required this.onTap, required this.doc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: doc['color'],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc['title'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              doc['content'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesApp extends StatelessWidget {
  NotesApp({Key? key}) : super(key: key);

  final repository = {
    'notes': [
      {
        'title': 'Note 1',
        'content': 'Content 1',
        'color': Colors.red,
      },
      {
        'title': 'Note 2',
        'content': 'Content 2',
        'color': Colors.green,
      },
      {
        'title': 'Note 3',
        'content': 'Content 3',
        'color': Colors.blue,
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withBlue(10),
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Defina o número de colunas desejado
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5, // Ajuste conforme necessário
        ),
        itemCount: repository['notes']!.length,
        itemBuilder: (context, index) {
          final note = repository['notes']![index];
          return NoteCard(
            onTap: () {
              // Adicione o que deseja fazer ao tocar no card, se necessário
            },
            doc: note,
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'Notes APP',
              iconData: Icons.book,
              onPress: () {
                Get.to(NotesApp());
              }),
          NavigationBarItem(
              label: 'Drawing Page',
              iconData: Icons.developer_board_off_sharp,
              onPress: () {
                Get.to(DrawingPage());
              }),
        ],
      ),
    );
  }
}
