import 'package:flutter/material.dart';
import 'package:ui_ux_mandiri/dbHelper/token.dart';
import 'package:ui_ux_mandiri/login.dart';
import 'package:ui_ux_mandiri/users/user.dart';
import 'package:ui_ux_mandiri/menu/settings.dart';


class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('NarutoHokage'),
            accountEmail: Text('naruto@gmail.com'),
            currentAccountPicture: GestureDetector(
              onTap: () {
                _showUserPopUp(context);
              },
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    "https://i.pinimg.com/236x/ae/2e/1d/ae2e1d04f74c59c6ebd46e3788dcef23.jpg",
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Friends'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          Divider(),
          ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                await AuthHelper.setLoggedIn(false);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              }),
        ],
      ),
    );
  }

  void _showUserPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return User();
      },
    );
  }
}
