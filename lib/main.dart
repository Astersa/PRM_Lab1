import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';

void main() => runApp(const SignupApp());

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 – Signup Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const SignupScreen(),
    );
  }
}
