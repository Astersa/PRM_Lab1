import 'package:flutter_test/flutter_test.dart';
import 'package:product_lab1/main.dart';

void main() {
  testWidgets('Taskly app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TasklyApp());
    expect(find.text('Taskly'), findsOneWidget);
  });
}
