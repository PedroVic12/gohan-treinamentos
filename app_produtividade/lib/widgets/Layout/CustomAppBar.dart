import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar CustomAppBar() {
  return AppBar(
    backgroundColor: Colors.black,
    bottomOpacity: BorderSide.strokeAlignCenter,
    elevation: 3,
    title: CustomText(
      text: 'Gohan Treinamentos Version 11 - 18/10/23',
      color: Colors.white,
      size: 14,
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.add_alert),
        tooltip: 'Show Snackbar',
        onPressed: () {
          Get.snackbar('Titulo', 'message', backgroundColor: Colors.redAccent);
        },
      ),
    ],
  );
}
