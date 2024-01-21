import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDMatrixTransition extends StatefulWidget {
  const ThreeDMatrixTransition({super.key});

  @override
  State<ThreeDMatrixTransition> createState() => _ThreeDMatrixTransitionState();
}

class _ThreeDMatrixTransitionState extends State<ThreeDMatrixTransition>
    with TickerProviderStateMixin {
  final _containerHeight = 100.0;
  final _containerWidth = 100.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MatrixTransition(
          alignment: Alignment.center,
          onTransform: (animationValue) => Matrix4.identity()
            ..setEntry(3, 2, 0.003)
            ..rotateY(animationValue),
          animation: _animation,
          child: Stack(
            children: [
              Container(
                height: _containerHeight,
                width: _containerWidth,
                color: Colors.grey.shade700,
              ),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()..rotateY(pi / 2),
                child: Container(
                  height: _containerHeight,
                  width: _containerWidth,
                  color: Colors.grey.shade200,
                ),
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()..rotateY(-pi / 2),
                child: Container(
                  height: _containerHeight,
                  width: _containerWidth,
                  color: Colors.grey.shade500,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(
                    Vector3(0, 0, -_containerWidth),
                  ),
                child: Container(
                  height: _containerHeight,
                  width: _containerWidth,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
