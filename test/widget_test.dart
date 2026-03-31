import 'package:flutter_test/flutter_test.dart';

import 'package:securepay_web/main.dart';

void main() {
  testWidgets('SecurePay homepage renders', (WidgetTester tester) async {
    await tester.pumpWidget(const SecurePayApp());

    expect(find.text('Skip'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('SecurePay Wallet Balance'), findsOneWidget);
    expect(find.text('Hello, User'), findsOneWidget);
  });
}
