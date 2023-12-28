import 'package:flutter/material.dart';
import 'package:ui_ux_mandiri/login.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/network/api.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: LoginPage(),
          bottomNavigationBar: Footer(),
        ),
    );
  }
}