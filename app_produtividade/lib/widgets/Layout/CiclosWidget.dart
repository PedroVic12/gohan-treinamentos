import 'package:flutter/material.dart';
import 'dart:math';

class CycleDiagram extends StatelessWidget {
  final List<String> texts = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            top: 150,
            left: 100,
            child: CircleText(text: texts[0]),
          ),
          Positioned(
            top: 50,
            left: 250,
            child: CircleText(text: texts[1]),
          ),
          Positioned(
            top: 150,
            left: 400,
            child: CircleText(text: texts[2]),
          ),
          Positioned(
            top: 250,
            left: 250,
            child: CircleText(text: texts[3]),
          ),
          CustomPaint(
            size: Size(500, 500),
            painter: ArrowPainter(),
          ),
        ],
      ),
    );
  }
}

class CircleText extends StatelessWidget {
  final String text;

  CircleText({required this.text});

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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final start = Offset(150, 175);
    final controlPoint1 = Offset(230, 75);
    final controlPoint2 = Offset(380, 75);
    final end = Offset(460, 175);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        end.dx,
        end.dy,
      );

    canvas.drawPath(path, paint);

    // Adicione as setas nos extremos do caminho
    drawArrow(canvas, start, controlPoint1);
    drawArrow(canvas, end, controlPoint2);
  }

  void drawArrow(Canvas canvas, Offset start, Offset end) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);

    // Desenhe a seta no final da linha
    final double arrowSize = 10;
    final double angle = 30;
    final double radians = angle * (pi / 180); // Use pi do pacote math
    final double x = end.dx - start.dx;
    final double y = end.dy - start.dy;
    final double length = sqrt(x * x + y * y); // Use sqrt do pacote math
    final double dx = x / length;
    final double dy = y / length;
    final Offset arrowEnd =
        Offset(end.dx - dx * arrowSize, end.dy - dy * arrowSize);
    final Offset arrow1 = Offset(
      arrowEnd.dx +
          dx * arrowSize * 1.5 * cos(radians), // Use cos do pacote math
      arrowEnd.dy +
          dy * arrowSize * 1.5 * sin(radians), // Use sin do pacote math
    );
    final Offset arrow2 = Offset(
      arrowEnd.dx +
          dx * arrowSize * 1.5 * cos(-radians), // Use cos do pacote math
      arrowEnd.dy +
          dy * arrowSize * 1.5 * sin(-radians), // Use sin do pacote math
    );

    path.moveTo(arrow1.dx, arrow1.dy);
    path.lineTo(end.dx, end.dy);
    path.lineTo(arrow2.dx, arrow2.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
