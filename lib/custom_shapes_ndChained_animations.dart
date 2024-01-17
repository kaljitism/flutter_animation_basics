import 'dart:math' show pi, sin, cos;

import 'package:flutter/material.dart';

class CustomShapesAnimation extends StatefulWidget {
  const CustomShapesAnimation({super.key});

  @override
  State<CustomShapesAnimation> createState() => _CustomShapesAnimationState();
}

class _CustomShapesAnimationState extends State<CustomShapesAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: Polygon(sides: 6),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.width / 2);
    final radius = size.width / 2;
    final angle = (2 * pi) / sides;
    final angles = List.generate(sides, (index) => index * angle);

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}
