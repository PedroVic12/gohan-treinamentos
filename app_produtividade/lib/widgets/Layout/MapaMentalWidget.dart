import 'package:flutter/material.dart';

class CirclesAndArrows extends StatelessWidget {
  const CirclesAndArrows({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50), // Espaço entre a seta e o círculo
              CircleWidget(text: '2'),
              ArrowWidget(rotation: 180, size: 30), // Rotação de 180 graus
            ],
          ),
          SizedBox(height: 50), // Espaço entre as linhas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ArrowWidget(size: 30), // Setas padrão sem rotação
              CircleWidget(text: '1'),
              SizedBox(width: 50), // Espaço entre o círculo e a seta
              ArrowWidget(),
              CircleWidget(text: '3'),
            ],
          ),
          SizedBox(height: 50), // Espaço
          CircleWidget(text: '4'),
          ArrowWidget(rotation: 45, size: 80),
        ],
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final String text;

  CircleWidget({Key? key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ArrowWidget extends StatelessWidget {
  final double rotation;
  final double size;

  ArrowWidget({Key? key, this.rotation = 0, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * (3.14159265359 / 180), // Converter graus para radianos
      child: Container(
        width: size,
        height: size,
        child: Icon(
          Icons.arrow_forward,
          size: size,
        ),
      ),
    );
  }
}
