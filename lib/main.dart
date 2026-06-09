import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'repositories/task_repository.dart';

void main() => runApp(TasklyApp(repository: TaskRepository()));

class TasklyApp extends StatelessWidget {
  final TaskRepository repository;
  const TasklyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: TaskListScreen(repository: repository),
    );
  }
}
