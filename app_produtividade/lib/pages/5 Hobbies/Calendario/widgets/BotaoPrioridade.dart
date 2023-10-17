import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';

Widget BotaoPrioridade({
  required String label,
  required Color color,
  required bool selected,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? color : Colors.grey,
      ),
      onPressed: onPressed,
      child: CustomText(
        text: label,
        size: 12,
        color: Colors.white,
      ),
    ),
  );
}
