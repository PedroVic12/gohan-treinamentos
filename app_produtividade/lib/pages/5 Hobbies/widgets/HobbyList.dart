import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbyController.dart';
import 'package:app_produtividade/pages/5%20Hobbies/widgets/HobbyItem.dart';
import 'package:flutter/material.dart';

class HobbyList extends StatelessWidget {
  final HobbyController controller;

  HobbyList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.hobbies.length,
        itemBuilder: (context, index) {
          final hobby = controller.hobbies[index];
          return HobbyItem(
            hobby: hobby,
            onTap: () => controller.incrementCount(index),
          );
        },
      ),
    );
  }
}
