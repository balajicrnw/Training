import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai/view/register_screen.dart';

void main() {
  testWidgets('RegisterScreen UI basic test', (WidgetTester tester) async {

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterScreen(),
        ),
      ),
    );

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Join Namma Kadai community'), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);

    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);

    expect(find.byType(RadioListTile<String>), findsNWidgets(2));

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    expect(find.byType(TextButton), findsOneWidget);
    expect(
      find.textContaining('Already have an account?', findRichText: true),
      findsOneWidget,
    );
  });
}