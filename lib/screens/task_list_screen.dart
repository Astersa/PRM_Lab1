import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = _textController.text.trim();
    if (title.isEmpty) return;
    context.read<TaskProvider>().addTask(title);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 12.2 – Pre-cached banner image
          Image.asset(
            'assets/images/task_banner.png',
            height: 60,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Input row – static widgets marked const
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('taskInputField'),
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  key: const Key('addTaskButton'),
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // 12.1 – Selector rebuilds only when task list changes
          Expanded(
            child: Selector<TaskProvider, List<Task>>(
              selector: (_, provider) => provider.tasks,
              builder: (context, tasks, _) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tasks yet. Add one!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(
                      // 12.1 – ValueKey for stable identity across rebuilds
                      key: ValueKey(task.id),
                      task: task,
                      onToggle: () =>
                          context.read<TaskProvider>().toggleTask(task),
                      onDelete: () =>
                          context.read<TaskProvider>().deleteTask(task.id),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TaskDetailScreen(taskId: task.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
