import 'package:flutter/material.dart';

import '../Hobbies/HobbyModel.dart';

class HobbyItem extends StatelessWidget {
  final Hobby hobby;
  final VoidCallback onTap;

  HobbyItem({required this.hobby, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(hobby.title),
        subtitle: Text(hobby.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(hobby.count.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
