import 'package:flutter/material.dart';
import 'exercises/exercise1_core_widgets.dart';
import 'exercises/exercise2_input_widgets.dart';
import 'exercises/exercise3_layout_basics.dart';
import 'exercises/exercise4_app_structure.dart';
import 'exercises/exercise5_debug_fixes.dart';

void main() => runApp(const Lab4App());

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 – Flutter UI Fundamentals',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const ExerciseMenuScreen(),
    );
  }
}

class ExerciseMenuScreen extends StatelessWidget {
  const ExerciseMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      ('Exercise 1: Core Widgets', const Exercise1Screen()),
      ('Exercise 2: Input Widgets', const Exercise2Screen()),
      ('Exercise 3: Layout Basics', const Exercise3Screen()),
      ('Exercise 4: App Structure', const Exercise4Screen()),
      ('Exercise 5: Debug Fixes', const Exercise5Screen()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 – Flutter UI')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final (title, screen) = exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen),
              ),
            ),
          );
        },
      ),
    );
  }
}
