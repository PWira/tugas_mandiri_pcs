// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ui_ux_mandiri/homepage.dart';

// class TestAPI extends StatefulWidget {
//   @override
//   _TestAPIState createState() => _TestAPIState();
// }

// class _TestAPIState extends State<TestAPI> {
//   var loginUsername = TextEditingController();
//   var loginPassword = TextEditingController();

//   var registerUsername = TextEditingController();
//   var registerPassword = TextEditingController();

//   Future<void> _loginUser() async {
//     final response = await http.post(Uri.parse("http://192.168.2.19/pcs_mandiri/login.php"), body: {
//       "username": loginUsername.text,
//       "password": loginPassword.text,
//     });

//     handleResponse(response, 'Login');

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       if (data['status'] == 'success') {
//         // Show login success notification
//         Fluttertoast.showToast(msg: 'Login successful');

//         // Navigate to the homepage after successful login
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//       } else {
//         // Show login failed notification
//         Fluttertoast.showToast(msg: 'Login failed: ${data['message']}');
//       }
//     }
//   }

//   Future<void> _registerUser() async {
//     final response = await http.post(Uri.parse("http://192.168.2.19/pcs_mandiri/register.php"), body: {
//       "username": registerUsername.text,
//       "password": registerPassword.text,
//     });

//     handleResponse(response, 'Register');

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       if (data['status'] == 'success') {
//         // Show registration success notification
//         Fluttertoast.showToast(msg: 'Registration successful');

//         // Clear text controllers after successful registration
//         registerUsername.clear();
//         registerPassword.clear();
//       } else {
//         // Show registration failed notification
//         Fluttertoast.showToast(msg: 'Registration failed: ${data['message']}');
//       }
//     }
//   }

//   void handleResponse(http.Response response, String action) {
//     // Common response handling logic can be added here if needed
//     // For now, it's empty since the specific handling is done within _loginUser and _registerUser
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             margin: EdgeInsets.only(top: 50),
//             padding: EdgeInsets.all(16),
//             height: 500.0,
//             width: 300.0,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'Login',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: loginUsername,
//                   decoration: InputDecoration(labelText: 'Username'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: loginPassword,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Password'),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   child: Text('Login'),
//                   onPressed: () {
//                     // Use FutureBuilder to handle asynchronous operation
//                     // This ensures that the UI remains responsive during the operation
//                     FutureBuilder<void>(
//                       future: _loginUser(),
//                       builder: (context, snapshot) {
//                         return snapshot.connectionState == ConnectionState.waiting
//                             ? CircularProgressIndicator() // Show a loading indicator
//                             : ElevatedButton(
//                                 // Continue with the original button if the operation is completed
//                                 child: Text('Login'),
//                                 onPressed: () {},
//                               );
//                       },
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 Divider(color: Colors.black, thickness: 5,),
//                 SizedBox(height: 16),
//                 Text(
//                   'Register',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextField(
//                   controller: registerUsername,
//                   decoration: InputDecoration(labelText: 'Username'),
//                 ),
//                 TextField(
//                   controller: registerPassword,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Password'),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   child: Text('Register'),
//                   onPressed: () {
//                     // Use FutureBuilder to handle asynchronous operation
//                     // This ensures that the UI remains responsive during the operation
//                     FutureBuilder<void>(
//                       future: _registerUser(),
//                       builder: (context, snapshot) {
//                         return snapshot.connectionState == ConnectionState.waiting
//                             ? CircularProgressIndicator() // Show a loading indicator
//                             : ElevatedButton(
//                                 // Continue with the original button if the operation is completed
//                                 child: Text('Register'),
//                                 onPressed: () {},
//                               );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
