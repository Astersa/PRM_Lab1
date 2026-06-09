import 'package:flutter/material.dart';
import 'screens/browse_screen.dart';

void main() => runApp(const MovieBrowseApp());

class MovieBrowseApp extends StatelessWidget {
  const MovieBrowseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 – Movie Genre Browsing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const BrowseScreen(),
    );
  }
}
