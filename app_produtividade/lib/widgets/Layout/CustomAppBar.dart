import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar CustomAppBar() {
  return AppBar(
    backgroundColor: Colors.black,
    bottomOpacity: BorderSide.strokeAlignCenter,
    title: const Text(
      'Gohan Treinamentos Version 10 - 13/09/23',
      style: TextStyle(color: Colors.white),
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
