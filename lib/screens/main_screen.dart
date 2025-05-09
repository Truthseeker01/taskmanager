import 'package:flutter/material.dart';
import 'package:tm/components/my_drawer.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/screens/completed_tasksscreen.dart';
import 'package:tm/screens/favorites_screen.dart';
import 'package:tm/screens/home_screen.dart';
import 'package:tm/screens/profile_screen.dart';

// class Task {
//   final String name;
//   final String description;
//   final bool isCompleted;

//   Task({required this.name, required this.description, this.isCompleted = false});
// }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;

  final List<Task> testTasks = [
    Task(name: "Buy groceries", description: "Milk, Bread, Eggs, Fruits"),
    Task(name: "Walk the dog", description: "Take Bella out for 30 minutes"),
    Task(name: "Flutter practice", description: "Build a task list UI"),
    Task(name: "Read a book", description: "Continue 'Atomic Habits'"),
    Task(name: "Clean room", description: "Vacuum and organize desk"),
  ];

  // final List<Task> completedTasks = [
  //   Task(name: "Buy groceries", description: "Milk, Bread, Eggs, Fruits", isCompleted: true),
  //   Task(name: "Walk the dog", description: "Take Bella out for 30 minutes", isCompleted: true),
  //   Task(name: "Flutter practice", description: "Build a task list UI", isCompleted: true),
  // ];

  void _onTaskDelete(Task task) {
    setState(() {
      testTasks.remove(task);
    });
  }

  void _onTaskRestore(Task task) {
    setState(() {
      testTasks.add(task);
    });
  }

  void _onTaskUpdate(Task task) {
    setState(() {
      testTasks[testTasks.indexOf(task)] = task;
    });
  }
  void _onTaskAdd(Task task) {
    setState(() {
      testTasks.add(task);
    });
  }
  

  final List<Task> favoriteTasks = [
    Task(name: "Read a book", description: "Continue 'Atomic Habits'", isCompleted: false),
    Task(name: "Clean room", description: "Vacuum and organize desk", isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {

    final Color backgroundColor = Colors.white;
    final Color appBarColor = Colors.blue;
    final Color textColor1 = Colors.white;
    final Color textColor2 = Colors.black;

    final List<Task> completedTasks = testTasks.where((task) => task.isCompleted).toList();

    
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

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
            HomeScreen(testTasks: testTasks),
            CompletedTasksscreen(completedTasks: completedTasks,),
            FavoritesScreen(favoriteTasks: favoriteTasks),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        selectedItemColor: appBarColor,
        unselectedItemColor: textColor2,
        onTap: _onItemTapped,
      ),
    );
  }
}