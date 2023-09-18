import 'package:flutter/material.dart';

class TelaCarregamento extends StatelessWidget {
  const TelaCarregamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100,
      height: 100,
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child:
                  CircularProgressIndicator(), // Ou qualquer outro widget de carregamento
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Carregando...'),
          )
        ],
      ),
    );
  }
}
