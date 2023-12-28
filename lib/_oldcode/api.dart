import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_ux_mandiri/homepage.dart';

class TestAPI extends StatefulWidget {
  @override
  _TestAPIState createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  var loginUsername = TextEditingController();
  var loginPassword = TextEditingController();

  var registerUsername = TextEditingController();
  var registerPassword = TextEditingController();

  Future<void> _loginUser() async {
    final response = await http.post(
      Uri.parse("http://192.168.100.73/pcs_mandiri/login.php"),
      body: {
        "username": loginUsername.text,
        "password": loginPassword.text,
      },
    );

    handleResponse(response, 'Login');
  }

  Future<void> _registerUser() async {
    final response = await http.post(
      Uri.parse("http://192.168.100.73/pcs_mandiri/register.php"),
      body: {
        "username": registerUsername.text,
        "password": registerPassword.text,
      },
    );

    print("Register response status code: ${response.statusCode}");
    print("Register response body: ${response.body}");

    handleResponse(response, 'Register');
  }

  void handleResponse(http.Response response, String action) {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        switch (action) {
          case 'Login':
            print('Login successful');
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 'Register':
            print('Registration successful');
            _clearRegisterInputs(); // Clear register inputs
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration successful!')),
            );
            break;
          default:
            print('Unknown action: $action');
        }
      } else {
        print('$action failed: ${data['message']}');
        // Display error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data['message']}')),
        );
      }
    } else {
      print('Failed to connect to the server');
      // Handle server connection failure
    }
  }

  // Function to clear register inputs
  void _clearRegisterInputs() {
    setState(() {
      registerUsername.clear();
      registerPassword.clear();
    });
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
          ),
        ),
      ),
    );
  }
}