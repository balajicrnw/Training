import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namma_kadai/main.dart';
import 'package:namma_kadai/firebase_options.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signOut();
  });

  testWidgets('Full App Flow Integration Test with GoRouter',
      (WidgetTester tester) async {

    FlutterError.onError = (details) {
      fail(details.exceptionAsString());
    };

    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('What would you like to buy today?'), findsOneWidget);

    final loginIcon = find.byIcon(Icons.login);
    if (loginIcon.evaluate().isNotEmpty) {
      await tester.tap(loginIcon);
      await tester.pumpAndSettle();
    }

    expect(find.text('Welcome Back'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'jameskidd123@gmail.com',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Jameskidd',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byIcon(Icons.logout), findsOneWidget);

    expect(find.byType(Image), findsWidgets);
    await tester.tap(find.byType(Image).first);
    await tester.pumpAndSettle();

    expect(find.text('Description'), findsOneWidget);

    final addToCart = find.text('Add to Cart');
    await tester.ensureVisible(addToCart);
    await tester.tap(addToCart);
    await tester.pumpAndSettle();

    expect(find.textContaining('added to cart'), findsWidgets);

    await tester.pump(const Duration(seconds: 2));


    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();

    expect(find.text('My Cart'), findsOneWidget);

    final placeOrder = find.widgetWithText(ElevatedButton, 'Place Order');
    await tester.ensureVisible(placeOrder);

    final snackBar = find.byType(SnackBar);
    if (snackBar.evaluate().isNotEmpty) {
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    } 

    await tester.tap(placeOrder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Order History'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 2));
  });
}