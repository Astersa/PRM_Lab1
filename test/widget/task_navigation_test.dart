import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/models/task.dart';
import 'package:product_lab1/repositories/task_repository.dart';
import 'package:product_lab1/screens/task_list_screen.dart';

void main() {
  group('Navigation tests', () {
    testWidgets('11.3 – tapping a task opens TaskDetailScreen', (tester) async {
      // Arrange – seed repository with one task
      final repo = TaskRepository();
      repo.addTask(Task(id: 'nav-1', title: 'Navigate Me'));

      await tester.pumpWidget(
        MaterialApp(home: TaskListScreen(repository: repo)),
      );

      // Act – tap the task tile
      await tester.tap(find.text('Navigate Me'));
      await tester.pumpAndSettle();

      // Assert – detail screen AppBar title
      expect(find.text('Task Detail'), findsOneWidget);

      // Assert – detail text field has correct key
      expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
    });
  });
}
