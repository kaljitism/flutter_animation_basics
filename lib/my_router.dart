import 'package:flutter/material.dart';
import 'package:flutter_animation_basics/3d_cube_animation.dart';
import 'package:flutter_animation_basics/chained_animation.dart';
import 'package:flutter_animation_basics/hero_animation.dart';
import 'package:flutter_animation_basics/implicit_rotateY_animation.dart';

class MyRouter extends StatefulWidget {
  const MyRouter({super.key});

  @override
  State<MyRouter> createState() => _MyRouterState();
}

class _MyRouterState extends State<MyRouter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation App'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImplicitRotateYAnimation(),
                ),
              );
            },
            title: const Text('Implicit Rotate Y Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChainedAnimation(),
                ),
              );
            },
            title: const Text('Chained Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThreeDCubeAnimation(),
                ),
              );
            },
            title: const Text('3D Cube Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HeroAnimation(),
                ),
              );
            },
            title: const Text('Hero Animation'),
          ),
        ],
      ),
    );
  }
}
