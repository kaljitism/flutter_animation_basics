import 'dart:math' show pi, sin, cos;

import 'package:flutter/material.dart';

class ThreeDTunnel extends StatefulWidget {
  const ThreeDTunnel({super.key});

  @override
  State<ThreeDTunnel> createState() => _ThreeDTunnelState();
}

List<Offset?> middlePointOfSide = [];

class _ThreeDTunnelState extends State<ThreeDTunnel>
    with TickerProviderStateMixin {
  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _sidesAnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(_sidesController);

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _scaleAnimation = Tween(
      begin: 50.0,
      end: 400.0,
    ).chain(CurveTween(curve: Curves.bounceInOut)).animate(_scaleController);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesController.repeat(reverse: true);
    _scaleController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _sidesController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _sidesAnimation,
            _scaleAnimation,
            _rotationAnimation,
          ]),
          builder: (context, child) {
            return Stack(
              children: [
                buildShape(),
                buildWalls(),
              ],
            );
          },
        ),
      ),
    );
  }

  Transform buildShape() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(_rotationAnimation.value)
        ..rotateY(_rotationAnimation.value)
        ..rotateZ(_rotationAnimation.value),
      child: CustomPaint(
        painter: Polygon(sides: _sidesAnimation.value),
        child: SizedBox(
          width: _scaleAnimation.value,
          height: _scaleAnimation.value,
        ),
      ),
    );
  }

  Transform buildWalls() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(_rotationAnimation.value)
        ..rotateY(_rotationAnimation.value)
        ..rotateZ(_rotationAnimation.value),
      child: middlePointOfSide.isNotEmpty
          ? Transform(
              alignment: Alignment(
                middlePointOfSide[0]!.dx,
                middlePointOfSide[0]!.dy,
              ),
              transform: Matrix4.identity()..rotateY((pi / 2)),
              child: CustomPaint(
                painter: ThreeDPolygon(sides: _sidesAnimation.value),
                child: SizedBox(
                  width: _scaleAnimation.value,
                  height: _scaleAnimation.value,
                ),
              ),
            )
          : Container(),
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

Offset calculateMiddlePoint(Offset edge1, Offset edge2) {
  final dx = edge2.dx - edge1.dx;
  final dy = edge2.dy - edge1.dy;

  final midpointX = edge1.dx + dx / 2;
  final midpointY = edge1.dy + dy / 2;

  return Offset(midpointX, midpointY);
}

class ThreeDPolygon extends CustomPainter {
  final int sides;

  ThreeDPolygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.width / 2);
    final radius = size.width / 2;
    final angle = (2 * pi) / sides;
    final angles = List.generate(sides, (index) => index * angle);

    List<Offset> pointPair = [
      Offset(
        center.dx + radius * cos(0),
        center.dy + radius * sin(0),
      ),
    ];

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    middlePointOfSide.clear();

    for (final angle in angles) {
      Offset nextPoint = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      pointPair.add(nextPoint);
      middlePointOfSide.add(calculateMiddlePoint(pointPair[0], pointPair[1]));
      path.lineTo(
        nextPoint.dx,
        nextPoint.dy,
      );
      pointPair.clear();
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}
