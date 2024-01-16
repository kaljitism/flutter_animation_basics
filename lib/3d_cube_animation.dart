import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDCubeAnimation extends StatefulWidget {
  const ThreeDCubeAnimation({super.key});

  @override
  State<ThreeDCubeAnimation> createState() => _ThreeDCubeAnimationState();
}

class _ThreeDCubeAnimationState extends State<ThreeDCubeAnimation>
    with TickerProviderStateMixin {
  // Width and Height for all 6 containers used in the cube.
  final double widthAndHeight = 150;

  // Animation Controllers
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  // Tween Object
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialising the animation controllers
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    // Initialising the Tween Object.
    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    // Disposing the controllers for performance
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // starting the animation controllers
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    // Front Face
                    Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.green,
                    ),
                    // Back Face
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -widthAndHeight)),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.purple,
                      ),
                    ),
                    // Left Face
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY((pi / 2)),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.yellow,
                      ),
                    ),
                    // Right Face
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-(pi / 2)),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.blue,
                      ),
                    ),
                    // Top Face
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.red,
                      ),
                    ),
                    // Bottom Face
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
