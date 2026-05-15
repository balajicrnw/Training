import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:namma_kadai/firebase_options.dart';
import 'package:namma_kadai/view/login_screen.dart';
import 'package:namma_kadai/view/checkout_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Login → Check order history in checkout screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'batman123@gmail.com',
    );
    await tester.pump();

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Batman',
    );
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    await tester.pumpAndSettle(const Duration(seconds: 10));
    final user = FirebaseAuth.instance.currentUser;
    expect(user, isNotNull);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CheckoutScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 8));


    expect(find.text('Order History'), findsOneWidget);
    final hasOrders = find.text('Order #1').evaluate().isNotEmpty;

    if (hasOrders) {
      expect(find.text('Order #1'), findsOneWidget);

      await tester.tap(find.text('Order #1'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Qty:'), findsWidgets);
      expect(find.byType(ListTile), findsWidgets);
    } else {
      expect(find.text('No orders yet'), findsOneWidget);
      expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);
    }
  });
}
