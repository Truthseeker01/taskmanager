import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tm/firebase_options.dart';
import 'package:tm/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase or any other services here if needed
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}