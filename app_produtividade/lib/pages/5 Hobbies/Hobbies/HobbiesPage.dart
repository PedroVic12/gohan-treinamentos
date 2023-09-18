import 'package:app_produtividade/controllers/ApiJson.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HobbiesPage extends StatelessWidget {
  final HobbiesController hobbiesController = HobbiesController();

  final controller = MeuHobbyController();

  HobbiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 hobbies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => hobbiesController.resetCounts(),
            tooltip: "Reset counts",
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Segunda, 18/06/2023'),
          const Text('You Only Need 5 hobbies'),
          const Text('Entender -> Aprender -> Praticar -> Aplicar'),
          Obx(
            () => controller.meusHobbies.isEmpty
                ? Center(
                    child:
                        CircularProgressIndicator(), // Ou qualquer outro widget de carregamento
                  )
                : ListView.builder(
                    itemCount: controller.meusHobbies.length,
                    itemBuilder: (context, index) {
                      final hobby = controller.meusHobbies[index];
                      return ListTile(
                        title: Text(hobby['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (hobby['description'] as List<dynamic>)
                              .map<Widget>((desc) {
                            return Text(desc.toString());
                          }).toList(),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}



