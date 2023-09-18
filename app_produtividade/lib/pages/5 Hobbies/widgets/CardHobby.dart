

import 'package:app_produtividade/controllers/ApiJson.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardHobby extends StatelessWidget {
  final MeuHobbyController controller = Get.put(MeuHobbyController());

  CardHobby({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.meusHobbies.length,
        itemBuilder: (context, index) {
          final hobby = controller.meusHobbies[index];
          return ListTile(
            title: Text(hobby['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  (hobby['description'] as List<dynamic>).map<Widget>((desc) {
                return Text(desc.toString());
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class CardHobbiesWidget extends StatelessWidget {
  final api_controller = ApiJsonController();

  CardHobbiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final itens = api_controller.dados;

    return ListView.builder(
        itemCount: api_controller.dados.length,
        itemBuilder: ((context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.amber.shade100,
            child: ListTile(
              title: Text(itens[index]['title']),
              subtitle: Text(itens[index]['description']),
            ),
          );
        }));
  }
}
