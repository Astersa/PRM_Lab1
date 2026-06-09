import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/repositories/task_repository.dart';
import 'package:product_lab1/screens/task_list_screen.dart';

void main() {
  group('11.4 – Integration: full add → edit → verify flow', () {
    testWidgets('add a task, edit its title, verify updated title in list',
        (tester) async {
      final repo = TaskRepository();
      await tester.pumpWidget(
        MaterialApp(home: TaskListScreen(repository: repo)),
      );

      // Step 1: Add "Original title"
      await tester.enterText(
          find.byKey(const Key('taskInputField')), 'Original title');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();
      expect(find.text('Original title'), findsOneWidget);

      // Step 2: Tap the task to open detail
      await tester.tap(find.text('Original title'));
      await tester.pumpAndSettle();
      expect(find.text('Task Detail'), findsOneWidget);

      // Step 3: Edit the title
      await tester.enterText(
          find.byKey(const Key('detailTitleField')), 'Updated title');

      // Step 4: Save
      await tester.tap(find.byKey(const Key('saveTaskButton')));
      await tester.pumpAndSettle();

      // Step 5: Verify updated title in list
      expect(find.text('Updated title'), findsOneWidget);
      expect(find.text('Original title'), findsNothing);
    });
  });
}
