import 'package:flutter/material.dart';
import 'package:tm/components/my_drawer.dart';
import 'package:tm/screens/completed_tasksscreen.dart';
import 'package:tm/screens/favorites_screen.dart';
import 'package:tm/screens/home_screen.dart';
import 'package:tm/screens/login_screen.dart';
import 'package:tm/screens/profile_screen.dart';
import 'package:tm/services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Color(0xFF00695c);
    final Color secondaryColor = Color(0xFFFFFFFF);
    final Color teritaoryColor = Color(0xFF212121);
    // final Color textColor2 = Colors.black;

    final AuthService authService = AuthService();
    // Get the current user
    final currentUser = authService.getCurrentUser();

    
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    if (currentUser == null) {
      return LoginScreen();
    } else {
      return mainPage(primaryColor, secondaryColor, teritaoryColor, onItemTapped);


  }
  }




  

  Scaffold mainPage(Color primaryColor, Color secondaryColor, Color teritaoryColor, Function(int) onItemTapped) {
    return Scaffold(
    drawer: _selectedIndex == 0 ? MyDrawer() : null,
    backgroundColor: primaryColor,
    appBar: AppBar(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: teritaoryColor,),
      title: Text(_selectedIndex == 0 ? 'Home' :
      _selectedIndex == 1 ? 'Completed Tasks' :
      _selectedIndex == 2 ? 'Favorites' : 'Profile'
      , style: TextStyle(color: teritaoryColor),),
      centerTitle: true,
    ),
    body: Container(
      color: Colors.transparent,
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          CompletedTasksscreen(),
          FavoritesScreen(),
          ProfileScreen(),
        ],
      ),
    ),
    bottomNavigationBar: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      child: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),  
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: appBarColor,
        unselectedItemColor: teritaoryColor.withOpacity(0.7),
        onTap: onItemTapped,
      ),
    ),
  );
  }
}