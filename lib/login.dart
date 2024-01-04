import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_ux_mandiri/homepage.dart';
import 'package:ui_ux_mandiri/loadpost.dart';
import 'package:ui_ux_mandiri/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginUsername = TextEditingController();
  var loginPassword = TextEditingController();

  Future<void> _loginUser() async {
    // final response = await http.post(Uri.parse("http://192.168.2.19/pcs_mandiri/login.php"), 
    final response = await http.post(Uri.parse("http://192.168.100.73/pcs_mandiri/login.php"), 
    body: {
      "username": loginUsername.text,
      "password": loginPassword.text,
    });

    handleResponse(response, 'Login');
  }

  void handleResponse(http.Response response, String action) {
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'success') {
          print('Login successful');
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print('$action failed: ${data['message']}');
      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${data['message']}')),
      );
    }
  } else {
    print('Failed to connect to the server');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(16),
            height: 500.0,
            width: 300.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: loginUsername,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: loginPassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: _loginUser,
                ),
                SizedBox(height: 16),
                Divider(color: Colors.black, thickness: 5,),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Register',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  onPressed: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) {
                        return RegisterPage();
                        },
                      )
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
