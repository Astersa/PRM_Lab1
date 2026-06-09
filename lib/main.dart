import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'repositories/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() => runApp(const TasklyApp());

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(TaskRepository()),
      child: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 12.2 – Pre-cache image asset so it loads instantly on first paint
    precacheImage(const AssetImage('assets/images/task_banner.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}
