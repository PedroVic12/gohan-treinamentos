import 'package:flutter/material.dart';

Widget BotaoPrioridade({
  required String label,
  required Color color,
  required bool selected,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? color : Colors.grey,
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
