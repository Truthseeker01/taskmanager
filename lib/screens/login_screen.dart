import 'package:flutter/material.dart';
import 'package:tm/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(onPressed:() {
              // Add your sign-up navigation logic here
            }, 
            child: const Text('Forgot Password?', style: TextStyle(fontSize: 12), textAlign: TextAlign.end,)
            ),
          ),
          const SizedBox(height: 20),
          const ElevatedButton(
            onPressed: null, // Add your login logic here
            child: Text('Login'),
          ),
          const SizedBox(height: 10),
          TextButton(onPressed:() {
            // Add your sign-up navigation logic here
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
          }, 
          child: const Text('Don\'t have an account? Sign up here.')
          ),
        ],
      ),
    );
  }
}