import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  String currentAvatar =
      'https://i.pinimg.com/236x/ae/2e/1d/ae2e1d04f74c59c6ebd46e3788dcef23.jpg';
  String currentUsername = 'NarutoHokage';
  String currentEmail = 'naruto@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              _changeAvatar(); 
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: Image.network(currentAvatar).image,
            ),
          ),
          SizedBox(height: 20),
          Text(
            currentUsername,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            currentEmail,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Kembali ke Beranda'),
          ),
        ],
      ),
    );
  }

  void _changeAvatar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Avatar'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentAvatar =
                      'https://example.com/path/to/new_avatar.jpg';
                });
                Navigator.pop(context);
              },
              child: Text('Select New Avatar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
