import 'package:flutter/material.dart';

class MyGestureDetector extends StatefulWidget {
  final Widget child;

  MyGestureDetector({required this.child});

  @override
  _MyGestureDetectorState createState() => _MyGestureDetectorState();
}

class _MyGestureDetectorState extends State<MyGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        child: widget.child,
      ),
    );
  }
}
