import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:namma_kadai/view/product_detail_screen.dart';
import 'package:namma_kadai/model/product.dart';
import 'package:namma_kadai/firebase_options.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('ProductDetailScreen Firebase UI test', (WidgetTester tester) async {

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
      ..imageUrl = data['imageUrl']
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProductDetailScreen(product: product),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(product.title), findsOneWidget);
    expect(find.text('₹${product.price}'), findsOneWidget);

    expect(find.text('Description'), findsOneWidget);
    expect(find.text(product.description), findsOneWidget);

    expect(find.text('Add to Cart'), findsOneWidget);

    expect(find.byType(SliverAppBar), findsOneWidget);

    expect(find.byType(Image), findsWidgets);
  });
}