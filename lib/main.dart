import 'package:flutter/material.dart';
import 'package:uts_pcs_putrawira/homepage.dart';
import 'package:uts_pcs_putrawira/menu/menu.dart';
import 'package:uts_pcs_putrawira/menu/footer.dart';

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