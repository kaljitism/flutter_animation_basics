import 'dart:math' as math;

import 'package:flutter/material.dart';

class TweenColorAnimation extends StatefulWidget {
  const TweenColorAnimation({super.key});

  @override
  State<TweenColorAnimation> createState() => _TweenColorAnimationState();
}

class _TweenColorAnimationState extends State<TweenColorAnimation> {
  Color _getRandomColor() =>
      Color(0xff000000 + math.Random().nextInt(0x00ffffff));

  late Color _randomColor;

  @override
  void initState() {
    super.initState();
    _randomColor = _getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ClipPath(
            clipper: const CircleClipper(),
            child: TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                onEnd: () {
                  setState(() {
                    _randomColor = _getRandomColor();
                  });
                },
                tween: ColorTween(
                  begin: _getRandomColor(),
                  end: _randomColor,
                ),
                builder: (context, value, child) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      value!,
                      BlendMode.srcATop,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      color: value,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
