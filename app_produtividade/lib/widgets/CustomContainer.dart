import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  final Color cor_container;

  final String conteudo;

  final Color cor_texto;

  const CustomContainer({required this.cor_container, required this.conteudo, required this.cor_texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: this.cor_container,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Texto: ' + this.conteudo),
      )),
    );
  }
}
