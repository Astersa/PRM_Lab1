import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final TaskRepository repository;
  const TaskListScreen({super.key, required this.repository});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _textController = TextEditingController();

  void _addTask() {
    final title = _textController.text.trim();
    if (title.isEmpty) return;
    setState(() {
      widget.repository.addTask(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ));
      _textController.clear();
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.toggle();
      widget.repository.updateTask(task);
    });
  }

  void _deleteTask(String id) {
    setState(() => widget.repository.deleteTask(id));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = widget.repository.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Add task input
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

          // Task list or empty state
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet. Add one!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        key: Key('task_${task.id}'),
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (_) => _toggleTask(task),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () => _deleteTask(task.id),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaskDetailScreen(
                              task: task,
                              repository: widget.repository,
                              onSaved: () => setState(() {}),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
