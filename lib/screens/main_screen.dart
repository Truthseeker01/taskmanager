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

    final Color backgroundColor = Colors.white;
    final Color appBarColor = Colors.blue;
    final Color textColor1 = Colors.white;
    final Color textColor2 = Colors.black;

    final AuthService authService = AuthService();
    // Get the current user
    final currentUser = authService.getCurrentUser();

    
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    if (currentUser == null) {
      return LoginScreen();
    } else {
      return mainPage(backgroundColor, appBarColor, textColor1, textColor2, _onItemTapped);


  }
  }




  

  Scaffold mainPage(Color backgroundColor, Color appBarColor, Color textColor1, Color textColor2, Function(int) _onItemTapped) {
    return Scaffold(
    drawer: _selectedIndex == 0 ? MyDrawer() : null,
    backgroundColor: backgroundColor,
    appBar: AppBar(
      backgroundColor: appBarColor,
      iconTheme: IconThemeData(color: textColor1,),
      title: Text(_selectedIndex == 0 ? 'My Tasks' :
      _selectedIndex == 1 ? 'Completed Tasks' :
      _selectedIndex == 2 ? 'Favorites' : 'Profile'
      , style: TextStyle(color: textColor1),),
      centerTitle: true,
    ),
    body: Container(
      color: backgroundColor,
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
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
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
        unselectedItemColor: textColor1.withOpacity(0.7),
        onTap: _onItemTapped,
      ),
    ),
  );
  }
}