import 'package:flutter/material.dart';

class CircleWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'Olá!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward,
      size: 24,
      color: Colors.black,
    );
  }
}

class ThreeCircles extends StatelessWidget {
  final String text1, text2, text3;

  const ThreeCircles({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: _CircleWithArrow(text: text1),
        ),
        Positioned(
          top: 150,
          left: 150,
          child: _CircleWithArrow(text: text2),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: _CircleWithArrow(text: text3),
        ),
      ],
    );
  }
}

class _CircleWithArrow extends StatelessWidget {
  final String text;

  const _CircleWithArrow({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: _ArrowPainter(),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width - 20, size.height / 2);
    canvas.drawPath(path, paint);

    var arrowPath = Path();
    arrowPath.moveTo(size.width - 20, size.height / 2);
    arrowPath.lineTo(size.width - 30, size.height / 2 - 5);
    arrowPath.lineTo(size.width - 30, size.height / 2 + 5);
    arrowPath.close();
    canvas.drawPath(arrowPath, paint);

    var circlePaint = Paint()..color = Colors.blue;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}
