import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/models/task.dart';

void main() {
  group('Task model', () {
    test('default completed value is false', () {
      // Arrange
      final task = Task(id: '1', title: 'Do homework');

      // Assert
      expect(task.completed, isFalse);
    });

    test('toggle() switches completed from false to true', () {
      // Arrange
      final task = Task(id: '2', title: 'Buy groceries');

      // Act
      task.toggle();

      // Assert
      expect(task.completed, isTrue);
    });

    test('toggle() switches completed from true to false', () {
      // Arrange
      final task = Task(id: '3', title: 'Exercise', completed: true);

      // Act
      task.toggle();

      // Assert
      expect(task.completed, isFalse);
    });
  });
}
