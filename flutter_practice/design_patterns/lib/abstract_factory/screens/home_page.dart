import 'package:flutter/material.dart';
import '../factory/ui_factory.dart';
import '../products/button/my_button.dart';
import '../products/text/my_text.dart';

class HomePage extends StatelessWidget {
  final UIFactory factory;

  const HomePage({super.key, required this.factory});

  @override
  Widget build(BuildContext context) {
    // Client code uses products through their abstract interfaces
    MyButton button = factory.createButton();
    MyText text = factory.createText();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text.build(context, 'Abstract Factory Pattern Demo'),
            const SizedBox(height: 32),
            button.build(
              context,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button Pressed!')),
                );
              },
              'Primary Action',
            ),
            const SizedBox(height: 16),
            const Text(
              'The app switches between LightFactory and DarkFactory based on the theme selection.',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
