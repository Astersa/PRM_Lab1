import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:product_lab1/models/task.dart';
import 'package:product_lab1/providers/task_provider.dart';
import 'package:product_lab1/repositories/task_repository.dart';
import 'package:product_lab1/screens/task_list_screen.dart';

void main() {
  group('Navigation tests', () {
    testWidgets('11.3 – tapping a task opens TaskDetailScreen', (tester) async {
      // Arrange – seed repository with one task
      final repo = TaskRepository();
      repo.addTask(Task(id: 'nav-1', title: 'Navigate Me'));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => TaskProvider(repo),
          child: const MaterialApp(home: TaskListScreen()),
        ),
      );

      // Act
      await tester.tap(find.text('Navigate Me'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Task Detail'), findsOneWidget);
      expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
    });
  });
}
