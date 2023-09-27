import 'package:flutter/material.dart';

class CampoDeTextoCard extends StatelessWidget {
  final Widget child;
  const CampoDeTextoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.grey,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
