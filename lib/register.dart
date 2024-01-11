import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_ux_mandiri/dbHelper/http_connector.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final httpC = getHttpC();
  var registerUsername = TextEditingController();
  var registerPassword = TextEditingController();

  Future<void> _registerUser() async {
    // final response = await http.post(Uri.parse("http://192.168.2.19/pcs_mandiri/register.php"),
    final response = await http.post(
        Uri.parse("http://${httpC}pcs_mandiri/register.php"),
        body: {
          "username": registerUsername.text,
          "password": registerPassword.text,
        });

    print("Register response status code: ${response.statusCode}");
    print("Register response body: ${response.body}");

    handleResponse(response, 'Register');
  }

  void handleResponse(http.Response response, String action) {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        print('Registration successful');
        _clearRegisterInputs(); // Clear register inputs
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
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

  void _clearRegisterInputs() {
    registerUsername.clear();
    registerPassword.clear();
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
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_outlined,
                    color: Colors.black,),
                    backgroundColor: Colors.white, // Set background color to transparent
                    elevation: 0, // Remove elevation
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: registerUsername,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      controller: registerPassword,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      child: Text('Register'),
                      onPressed: _registerUser,
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
