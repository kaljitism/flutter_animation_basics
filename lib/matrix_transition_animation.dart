import 'dart:math';

import 'package:flutter/material.dart';

class MatrixTransitionAnimation extends StatefulWidget {
  const MatrixTransitionAnimation({super.key});

  @override
  State<MatrixTransitionAnimation> createState() =>
      _MatrixTransitionAnimationState();
}

class _MatrixTransitionAnimationState extends State<MatrixTransitionAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MatrixTransition(
          alignment: Alignment.center,
          animation: _animation,
          child: const FlutterLogo(
            size: 150.0,
            textColor: Colors.yellow,
          ),
          onTransform: (animationValue) {
            return Matrix4.identity()
              ..setEntry(3, 2, 0.004)
              ..rotateY(pi * 2.0 * animationValue);
          },
        ),
      ),
    );
  }
}
