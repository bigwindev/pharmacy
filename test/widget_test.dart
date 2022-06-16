import 'package:flutter_test/flutter_test.dart';

import 'package:pharmacy/main.dart';

void main() {
  testWidgets('Display Home screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that title.
    expect(find.text('Home Page'), findsOneWidget);
  });
}
