import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String username;
  final String email;

  User({required this.username, required this.email});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Forum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatelessWidget {
  final List<User> users = [
    User(username: 'user1', email: 'user1@example.com'),
    User(username: 'user2', email: 'user2@example.com'),
    // ... tambahkan pengguna lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Forum'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].username),
            subtitle: Text(users[index].email),
            onTap: () {
              _showUserDialog(context, users[index]);
            },
          );
        },
      ),
    );
  }

  void _showUserDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Username: ${user.username}'),
              SizedBox(height: 8.0),
              Text('Email: ${user.email}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
