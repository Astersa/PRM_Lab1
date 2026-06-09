import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:product_lab1/providers/task_provider.dart';
import 'package:product_lab1/repositories/task_repository.dart';
import 'package:product_lab1/screens/task_list_screen.dart';

Widget buildTestApp() {
  return ChangeNotifierProvider(
    create: (_) => TaskProvider(TaskRepository()),
    child: const MaterialApp(home: TaskListScreen()),
  );
}

void main() {
  group('TaskListScreen widget tests', () {
    testWidgets('11.2 – shows empty state text when no tasks', (tester) async {
      await tester.pumpWidget(buildTestApp());
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    });

    testWidgets('11.2 – adding a task displays it in the list', (tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.enterText(find.byKey(const Key('taskInputField')), 'Buy milk');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      expect(find.text('Buy milk'), findsOneWidget);
      expect(find.text('No tasks yet. Add one!'), findsNothing);
    });

    testWidgets('11.2 – multiple tasks all appear in list', (tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.enterText(find.byKey(const Key('taskInputField')), 'Task Alpha');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      await tester.enterText(find.byKey(const Key('taskInputField')), 'Task Beta');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      expect(find.text('Task Alpha'), findsOneWidget);
      expect(find.text('Task Beta'), findsOneWidget);
    });
  });
}
