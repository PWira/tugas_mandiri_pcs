import 'package:flutter/material.dart';
import 'package:ui_ux_mandiri/homepage.dart';
import 'package:ui_ux_mandiri/post.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostPage(),
    );
  }
}
