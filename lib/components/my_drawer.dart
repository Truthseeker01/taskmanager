import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final Color backgroundColor = Colors.white;
    final Color appBarColor = Colors.blue;
    final Color textColor1 = Colors.white;
    final Color textColor2 = Colors.black;

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
                  fontSize: 24, // Responsive font size
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: textColor2),
              title: Text('Home', style: TextStyle(color: textColor2)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: textColor2),
              title: Text('Settings', style: TextStyle(color: textColor2)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to settings screen if implemented
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: textColor2),
              title: Text('Logout', style: TextStyle(color: textColor2)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Implement logout functionality here
              },
            ),
          ],
        ),
      );
  }
}