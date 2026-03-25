import 'package:flutter/material.dart';
import 'abstract_factory/factory/light_factory.dart';
import 'abstract_factory/factory/dark_factory.dart';
import 'abstract_factory/factory/ui_factory.dart';
import 'abstract_factory/screens/home_page.dart' as af;
import 'abstract_factory/core/theme_selector.dart';
import 'builder_pattern/screens/home_page.dart' as bp;
import 'factory_method/screens/api_example_page.dart' as fm;


class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design Patterns')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Abstract Factory'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const _AbstractFactoryPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Builder Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const bp.HomePage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Factory Method'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const fm.ApiExamplePage()),
            ),
          ),
          const Divider(),  
        ],
      ),
    );
  }
}

class _AbstractFactoryPage extends StatefulWidget {
  const _AbstractFactoryPage();

  @override
  State<_AbstractFactoryPage> createState() => _AbstractFactoryPageState();
}

class _AbstractFactoryPageState extends State<_AbstractFactoryPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final UIFactory factory = isDark ? DarkFactory() : LightFactory();
    return Scaffold(
      appBar: AppBar(title: const Text('Abstract Factory')),
      body: Column(
        children: [
          ThemeSelector(
            isDark: isDark,
            onThemeChanged: (v) => setState(() => isDark = v),
          ),
          const Divider(),
          Expanded(child: af.HomePage(factory: factory)),
        ],
      ),
    );
  }
}
