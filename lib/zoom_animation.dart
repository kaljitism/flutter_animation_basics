import 'package:flutter/material.dart';

class ZoomAnimation extends StatefulWidget {
  const ZoomAnimation({super.key});

  @override
  State<ZoomAnimation> createState() => _ZoomAnimationState();
}

class _ZoomAnimationState extends State<ZoomAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/zoom_example.jpg'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Zoom In'),
            ),
          ],
        ),
      ),
    );
  }
}
