import 'package:flutter/material.dart';
import 'package:tm/screens/main_screen.dart';
import 'package:tm/screens/reset_password.dart';
import 'package:tm/screens/signup_screen.dart';
import 'package:tm/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final AuthService authService = AuthService();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: passwordController,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
            }, 
            child: const Text('Forgot Password?', style: TextStyle(fontSize: 12), textAlign: TextAlign.end,)
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async{
              try {
                await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
              }
            },
            child: Text('Login'),
          ),
          const SizedBox(height: 10),
          TextButton(onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
          }, 
          child: const Text('Don\'t have an account? Sign up here.')
          ),
        ],
      ),
    );
  }
}