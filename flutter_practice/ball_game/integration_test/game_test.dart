import 'package:ball_game/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Manda adi test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Mainmenu(),
    ));

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Play"), findsOneWidget);

    for (int i = 0; i < 3; i++) {
      await tester.tap(find.byType(Image));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    for (int i = 0; i < 400; i++) {
      await tester.pump(const Duration(milliseconds: 100));

      final animatedList = find.byType(AnimatedOpacity).evaluate();

      for (final element in animatedList) {
        final widget = element.widget as AnimatedOpacity;

        if (widget.opacity == 1.0) {
          final finder = find.byElementPredicate((e) => e == element);
          await tester.tap(finder);
        }
      }
    }

    await tester.pump(const Duration(seconds: 2));
  });
}