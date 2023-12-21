import 'package:flutter/material.dart';
import 'package:ui_ux_mandiri/homepage.dart';
import 'package:ui_ux_mandiri/menu/menu.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/tools/route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: NavBar(),
          appBar: AppBar(
            title: Text('Dashboard'),
          ),
          body: HomePage(),
          bottomNavigationBar: Footer(),
        ),
    );
  }
}