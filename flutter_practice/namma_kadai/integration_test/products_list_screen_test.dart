import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:namma_kadai/view/product_list_screen.dart';
import 'package:namma_kadai/firebase_options.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "test.db");

    await openDatabase(path);
  });

  testWidgets('ProductListScreen UI basic test', (WidgetTester tester) async {

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ProductListScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('What would you like to buy today?'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search items...'), findsOneWidget);

    expect(find.text('All'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
    expect(find.text('Fashion'), findsOneWidget);
    expect(find.text('Electronics'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    expect(find.byType(FilterChip), findsNWidgets(5));

    expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
  });
}