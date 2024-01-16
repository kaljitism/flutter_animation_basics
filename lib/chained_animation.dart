import 'package:flutter/material.dart';

class ChainedAnimation extends StatefulWidget {
  const ChainedAnimation({super.key});

  @override
  State<ChainedAnimation> createState() => _ChainedAnimationState();
}

class _ChainedAnimationState extends State<ChainedAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: const Color(0xff0057b7),
              ),
              Container(
                height: 200,
                width: 200,
                color: const Color(0xffffd700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
