import 'dart:math';

import 'package:flutter/material.dart';

class GenArtAnimation extends StatefulWidget {
  const GenArtAnimation({super.key});

  @override
  State<GenArtAnimation> createState() => _GenArtAnimationState();
}

class _GenArtAnimationState extends State<GenArtAnimation>
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
      duration: const Duration(seconds: 20),
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

  int generateRandomValue() {
    // Generate a random integer between 0 and 6 (inclusive).
    int randomInt = Random().nextInt(7);

    // Shift the value to the desired range of 3 to 9.
    return randomInt + 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                  animation: Listenable.merge([
                    _rotationAnimation,
                    _scaleAnimation,
                    _sidesAnimation,
                  ]),
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateX(Random().nextDouble())
                        ..rotateY(Random().nextDouble())
                        ..rotateZ(Random().nextDouble()),
                      child: CustomPaint(
                        painter: Polygon(sides: generateRandomValue()),
                        child: SizedBox(
                          width: _scaleAnimation.value,
                          height: _scaleAnimation.value,
                        ),
                      ),
                    );
                  });
            }),
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
