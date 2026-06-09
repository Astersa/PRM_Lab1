import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/main.dart';
import 'package:product_lab1/repositories/task_repository.dart';

void main() {
  testWidgets('Taskly app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(TasklyApp(repository: TaskRepository()));
    expect(find.text('Taskly'), findsOneWidget);
  });
}
