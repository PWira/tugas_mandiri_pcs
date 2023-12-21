import 'package:flutter/material.dart';
import 'package:uts_pcs_putrawira/homepage.dart';
import 'package:uts_pcs_putrawira/post.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (context) =>const HomePage());
      case '/post':
        return MaterialPageRoute(builder: (context) =>const PostPage());
        default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(
      builder: (context){
        return Scaffold(
          appBar: AppBar(title: Text('Error!')),
          body: const Center(child: Text('Error Page'),),
        );
      }
    );
  }
}