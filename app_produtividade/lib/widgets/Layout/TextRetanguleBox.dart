import 'package:flutter/material.dart';

class CaixaTextoRetangulo extends StatelessWidget {
  final String text;

  const CaixaTextoRetangulo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 8,
        ),
      ),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(text, style: TextStyle(fontSize: 25)),
      )),
    );
  }
}
