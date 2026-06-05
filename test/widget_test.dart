import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/main.dart';

void main() {
  testWidgets('Wallet app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WalletApp());

    // Verify that the initial screen loads (contains "Mis Gastos")
    expect(find.text('Mis Gastos'), findsOneWidget);
  });
}
