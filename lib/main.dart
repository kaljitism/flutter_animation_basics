import 'package:flutter/material.dart';
import 'package:flutter_animation_basics/threeD_drawer.dart';

void main() {
  runApp(const MyAnimationApp());
}

class MyAnimationApp extends StatelessWidget {
  const MyAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation App',
      theme: ThemeData.dark(useMaterial3: true),
      home: const DrawerPage(),
    );
  }
}
