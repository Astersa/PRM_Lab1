import 'package:flutter/material.dart';
import 'screens/lab9_home_screen.dart';

void main() => runApp(const Lab9App());

class Lab9App extends StatelessWidget {
  const Lab9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 9 – Local JSON Storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const Lab9HomeScreen(),
    );
  }
}
