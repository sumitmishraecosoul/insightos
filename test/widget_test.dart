
import 'package:flutter_test/flutter_test.dart';

import 'package:insightos/main.dart';

void main() {
  testWidgets('App boots to Brand Report', (WidgetTester tester) async {
    await tester.pumpWidget(const InsightOsApp());
    await tester.pump(const Duration(milliseconds: 10));

    expect(find.text('Brand Report'), findsOneWidget);
  });
}
