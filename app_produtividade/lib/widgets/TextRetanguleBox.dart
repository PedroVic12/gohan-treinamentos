import 'package:flutter/material.dart';

class CaixaTextoRetangulo extends StatelessWidget {
  final String string_parametro;

  const CaixaTextoRetangulo({super.key, required this.string_parametro});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              'Momento chill: ' +
                  this.string_parametro.toString() +
                  '- Recebo um parametro!',
              style: TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
