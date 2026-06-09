import 'package:flutter/material.dart';

class Exercise4Screen extends StatefulWidget {
  const Exercise4Screen({super.key});

  @override
  State<Exercise4Screen> createState() => _Exercise4ScreenState();
}

class _Exercise4ScreenState extends State<Exercise4Screen> {
  bool _isDarkMode = false;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = _isDarkMode
        ? ThemeData(
            colorSchemeSeed: Colors.deepPurple,
            brightness: Brightness.dark,
            useMaterial3: true,
          )
        : ThemeData(
            colorSchemeSeed: Colors.deepPurple,
            brightness: Brightness.light,
            useMaterial3: true,
          );

    return Theme(
      data: theme,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Exercise 4: App Structure'),
            actions: [
              IconButton(
                icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                tooltip: 'Toggle dark mode',
                onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.flutter_dash,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Counter: $_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  _isDarkMode ? 'Dark mode is ON' : 'Light mode is ON',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => _counter++),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
