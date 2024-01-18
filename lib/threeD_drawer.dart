import 'dart:math';

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;

  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChildTranslation;
  late Animation<double> _yRotationChildAnimation;
  late AnimationController _xControllerForDrawerTranslation;
  late Animation<double> _yRotationDrawerAnimation;

  @override
  void initState() {
    super.initState();
    _xControllerForChildTranslation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yRotationChildAnimation = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_xControllerForChildTranslation);

    _xControllerForDrawerTranslation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yRotationDrawerAnimation = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_xControllerForDrawerTranslation);
  }

  @override
  void dispose() {
    _xControllerForChildTranslation.dispose();
    _xControllerForDrawerTranslation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xControllerForChildTranslation.value += details.delta.dx / maxDrag;
        _xControllerForDrawerTranslation.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChildTranslation.value < 0.5) {
          _xControllerForChildTranslation.reverse();
          _xControllerForDrawerTranslation.reverse();
        } else {
          _xControllerForChildTranslation.forward();
          _xControllerForDrawerTranslation.forward();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _yRotationChildAnimation,
            _yRotationDrawerAnimation,
          ]),
          builder: (context, child) {
            return Stack(
              children: [
                Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xControllerForChildTranslation.value * maxDrag)
                    ..rotateY(_yRotationChildAnimation.value),
                  child: widget.child,
                ),
                Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(-screenWidth +
                        _xControllerForDrawerTranslation.value * maxDrag)
                    ..rotateY(_yRotationDrawerAnimation.value),
                  child: widget.drawer,
                ),
              ],
            );
          }),
    );
  }
}

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 100, left: 100),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('3D Drawer'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Swipe to open the Drawer!'),
        ),
      ),
    );
  }
}
