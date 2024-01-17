import 'package:flutter/material.dart';

class ZoomAnimation extends StatefulWidget {
  const ZoomAnimation({super.key});

  @override
  State<ZoomAnimation> createState() => _ZoomAnimationState();
}

class _ZoomAnimationState extends State<ZoomAnimation> {
  double _width = 100;
  bool _isZoomedIn = false;
  String _buttonTitle = 'Zoom In';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 370),
                  curve: Curves.bounceOut,
                  width: _width,
                  child: Image.asset('assets/zoom_example.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isZoomedIn = !_isZoomedIn;
                    _buttonTitle = _isZoomedIn ? 'Zoom Out' : 'Zoom In';
                    _width = _isZoomedIn
                        ? MediaQuery.of(context).size.width - 20
                        : 100;
                  });
                },
                child: Text(_buttonTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
