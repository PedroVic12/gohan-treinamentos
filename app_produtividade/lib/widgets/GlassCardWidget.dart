import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class BlurGlassCardWidget extends StatelessWidget {
  final List eventos;

  const BlurGlassCardWidget({Key? key, required this.eventos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GlassContainer(
        height: 200,
        width: 350,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.40),
            Colors.white.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.purpleAccent.withOpacity(0.05),
            Colors.purpleAccent.withOpacity(0.60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.39, 0.40, 1.0],
        ),
        blur: 32,
        borderRadius: BorderRadius.circular(24.0),
        borderWidth: 1.0,
        elevation: 3.0,
        isFrostedGlass: true,
        shadowColor: Colors.purple.withOpacity(0.20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eventos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    final evento = eventos[index];
                    return ListTile(
                      title: Text(evento.nomeEvento),
                      subtitle: Text(
                          'Data: ${evento.inicio.day}/${evento.inicio.month}/${evento.inicio.year}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
