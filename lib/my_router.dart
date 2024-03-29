import 'package:flutter/material.dart';
import 'package:flutter_animation_basics/3d_cube_animation.dart';
import 'package:flutter_animation_basics/3d_drawer.dart';
import 'package:flutter_animation_basics/3d_matrix_transition.dart';
import 'package:flutter_animation_basics/3d_tunnel_animation.dart';
import 'package:flutter_animation_basics/animated_prompt.dart';
import 'package:flutter_animation_basics/chained_animation.dart';
import 'package:flutter_animation_basics/custom_shapes_ndChained_animations.dart';
import 'package:flutter_animation_basics/gen_art_animation.dart';
import 'package:flutter_animation_basics/hero_animation.dart';
import 'package:flutter_animation_basics/implicit_rotateY_animation.dart';
import 'package:flutter_animation_basics/matrix_transition_animation.dart';
import 'package:flutter_animation_basics/zoom_animation.dart';

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
                  builder: (context) => const ThreeDTunnel(),
                ),
              );
            },
            title: const Text('3D Tunnel Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThreeDMatrixTransition(),
                ),
              );
            },
            title: const Text('3D Matrix Transition'),
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
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MatrixTransitionAnimation(),
                ),
              );
            },
            title: const Text('Matrix Transition'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ZoomAnimation(),
                ),
              );
            },
            title: const Text('Zoom Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomShapesAnimation(),
                ),
              );
            },
            title: const Text('Custom Shapes Animation'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DrawerPage(),
                ),
              );
            },
            title: const Text('3D Drawer'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnimatedPromptPage(),
                ),
              );
            },
            title: const Text('Animated Prompt'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenArtAnimation(),
                ),
              );
            },
            title: const Text('Gen Art Animation'),
          ),
        ],
      ),
    );
  }
}
