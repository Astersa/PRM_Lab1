import 'package:flutter/material.dart';
import 'screens/posts_screen.dart';

void main() => runApp(const Lab8App());

class Lab8App extends StatelessWidget {
  const Lab8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 – API List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const PostsScreen(),
    );
  }
}
