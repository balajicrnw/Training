import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai/view/login_screen.dart';

void main() {
  testWidgets('LoginScreen UI basic test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login to continue shopping'), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.textContaining('Don\'t have an account?', findRichText: true), findsOneWidget);
  });
}
