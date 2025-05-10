import 'package:flutter/material.dart';
import 'package:tm/screens/login_screen.dart';
import 'package:tm/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final Color backgroundColor = Colors.white;
    final Color appBarColor = Colors.blue;
    final Color textColor1 = Colors.white;
    final Color textColor2 = Colors.black;

    final AuthService authService = AuthService();

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: appBarColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: textColor1,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: textColor2),
              title: Text('Home', style: TextStyle(color: textColor2)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: textColor2),
              title: Text('Settings', style: TextStyle(color: textColor2)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: textColor2),
              title: Text('Logout', style: TextStyle(color: textColor2)),
              onTap: () {
                authService.signOut(); 
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); 
              
              },
            ),
          ],
        ),
      );
  }
}