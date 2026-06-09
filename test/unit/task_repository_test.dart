import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/models/task.dart';
import 'package:product_lab1/repositories/task_repository.dart';

void main() {
  late TaskRepository repo;

  setUp(() => repo = TaskRepository());

  group('TaskRepository', () {
    test('addTask() increases task count', () {
      // Arrange
      final task = Task(id: '1', title: 'Learn Flutter');

      // Act
      repo.addTask(task);

      // Assert
      expect(repo.tasks.length, 1);
      expect(repo.tasks.first.title, 'Learn Flutter');
    });

    test('deleteTask() removes correct task by id', () {
      // Arrange
      final t1 = Task(id: '1', title: 'Task One');
      final t2 = Task(id: '2', title: 'Task Two');
      repo.addTask(t1);
      repo.addTask(t2);

      // Act
      repo.deleteTask('1');

      // Assert
      expect(repo.tasks.length, 1);
      expect(repo.tasks.first.id, '2');
    });

    test('updateTask() replaces task with same id', () {
      // Arrange
      final original = Task(id: '1', title: 'Original');
      repo.addTask(original);

      // Act
      final updated = original.copyWith(title: 'Updated', completed: true);
      repo.updateTask(updated);

      // Assert
      final found = repo.findById('1');
      expect(found?.title, 'Updated');
      expect(found?.completed, isTrue);
    });

    test('findById() returns null for missing id', () {
      expect(repo.findById('nonexistent'), isNull);
    });
  });
}
