import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double textSize;
  final VoidCallback onPressed;
  final double size;

  const ProductivityButton(
      {required this.color,
      required this.text,
      required this.textSize,
      required this.onPressed,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: textSize,
        ),
      ),
    );
  }
}
