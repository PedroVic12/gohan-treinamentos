import 'package:app_produtividade/pages/5%20Hobbies/HobbiesModel.dart';
import 'package:flutter/material.dart';

class HobbiesPage extends StatefulWidget {
  @override
  _HobbiesPageState createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {
  final List<Hobby> hobbies = [
    Hobby(
        title: "One to make your money", description: "Estágio em Engenharia"),
    // ... adicione outros hobbies aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("5 Hobbies")),
      body: ListView.builder(
        itemCount: hobbies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(hobbies[index].title),
            subtitle: Text(hobbies[index].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(hobbies[index].count.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      hobbies[index].count++;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
