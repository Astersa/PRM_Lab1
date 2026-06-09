import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;

  TaskProvider(this._repository);

  List<Task> get tasks => _repository.tasks;

  void addTask(String title) {
    _repository.addTask(Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    ));
    notifyListeners();
  }

  void deleteTask(String id) {
    _repository.deleteTask(id);
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.toggle();
    _repository.updateTask(task);
    notifyListeners();
  }

  void updateTaskTitle(String id, String newTitle) {
    final task = _repository.findById(id);
    if (task == null) return;
    _repository.updateTask(task.copyWith(title: newTitle));
    notifyListeners();
  }
}
