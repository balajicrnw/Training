import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:namma_kadai/firebase_options.dart';
import 'package:namma_kadai/model/product.dart';
import 'package:namma_kadai/view/login_screen.dart';
import 'package:namma_kadai/view/product_detail_screen.dart';
import 'package:namma_kadai/view/cart_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Login → Add product → Check cart', (WidgetTester tester) async {
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
      'kenway123@gmail.com',
    );
    await tester.pump();

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Kenway',
    );
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    await tester.pumpAndSettle(const Duration(seconds: 10));

    final user = FirebaseAuth.instance.currentUser;
    expect(user, isNotNull);

    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .limit(1)
        .get();

    expect(snapshot.docs.isNotEmpty, true);

    final doc = snapshot.docs.first;
    final data = doc.data();

    final product = Product((b) => b
      ..id = doc.id
      ..title = data['title']
      ..price = data['price']
      ..description = data['description']
      ..imageUrl = data['imageUrl']);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProductDetailScreen(product: product),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Add to Cart'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CartScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('My Cart'), findsOneWidget);
  });
}
