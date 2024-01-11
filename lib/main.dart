import 'package:flutter/material.dart';
import 'package:ui_ux_mandiri/dbHelper/token.dart';
import 'package:ui_ux_mandiri/login.dart';
import 'package:ui_ux_mandiri/pages/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await AuthHelper.isLoggedIn();

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  MainApp({required this.isLoggedIn});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: isLoggedIn ? HomePage() : LoginPage(),
        ),
    );
  }
}