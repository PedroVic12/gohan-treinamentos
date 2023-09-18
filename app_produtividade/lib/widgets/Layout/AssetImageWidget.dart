import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Largura da imagem
      height: 200, // Altura da imagem
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Cor da sombra
            spreadRadius: 5, // Raio da sombra
            blurRadius: 7, // Desfoque da sombra
            offset: Offset(0, 3), // Posição da sombra
          ),
        ],
      ),
      child: Image.asset(
        'assets/your_image.png', // Caminho para a imagem
        fit: BoxFit.cover, // Ajuste da imagem dentro do container
      ),
    );
  }
}
