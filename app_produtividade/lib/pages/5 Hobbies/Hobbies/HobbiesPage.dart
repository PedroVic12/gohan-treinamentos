import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesController.dart';
import 'package:app_produtividade/pages/5%20Hobbies/HobbiesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogPage extends StatelessWidget {
  final HobbiesController hobbiesController = HobbiesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 hobbies'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => hobbiesController.resetCounts(),
            tooltip: "Reset counts",
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Segunda, 12/06/2023'),
          const Text('You Only Need 5 hobbies'),
          const Text('Entender -> Aprender -> Praticar -> Aplicar'),
          Expanded(
            child: Obx(() {
              if (hobbiesController.isLoading) {
                // Exibe o indicador de carregamento
                return Center(child: CircularProgressIndicator());
              } else {
                // Exibe a lista de hobbies
                return ListView.builder(
                  itemCount: hobbiesController.hobbies.length,
                  itemBuilder: (context, index) {
                    final hobby = hobbiesController.hobbies[index];
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
                              onPressed: () =>
                                  hobbiesController.incrementHobby(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
