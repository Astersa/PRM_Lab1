import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8B – Weather Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}
