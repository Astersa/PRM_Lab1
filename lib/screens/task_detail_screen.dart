import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final TaskRepository repository;
  final VoidCallback onSaved;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.repository,
    required this.onSaved,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _save() {
    final newTitle = _titleController.text.trim();
    if (newTitle.isEmpty) return;
    final updated = widget.task.copyWith(title: newTitle);
    widget.repository.updateTask(updated);
    widget.onSaved();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('detailTitleField'),
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Completed: '),
                Switch(
                  value: widget.task.completed,
                  onChanged: (_) {
                    setState(() => widget.task.toggle());
                    widget.repository.updateTask(widget.task);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              key: const Key('saveTaskButton'),
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
