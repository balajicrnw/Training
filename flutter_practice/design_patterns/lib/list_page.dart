import 'package:design_patterns/bridge_pattern/bridge_pattern_page.dart';
import 'package:design_patterns/chain_of_responsibility/order_page.dart';
import 'package:design_patterns/command_pattern/cart_page.dart';
import 'package:design_patterns/composite_pattern/file_page.dart';
import 'package:design_patterns/decorator_pattern/ui/coffee_page.dart';
import 'package:design_patterns/facade_pattern/presentation/computer_page.dart';
import 'package:design_patterns/flyweight_pattern/screens/flyweight_demo.dart';
import 'package:design_patterns/interpreter_pattern/interpreter_ui.dart';
import 'package:design_patterns/mediator_pattern/ui/chat_page.dart';
import 'package:design_patterns/memento_pattern/ui/drawing_page.dart';
import 'package:design_patterns/observer_pattern/observer_page.dart';
import 'package:design_patterns/proxy_pattern/ui/proxy_page.dart';
import 'package:design_patterns/strategy_pattern/ui/checkout_page.dart';
import 'package:design_patterns/template_pattern/ui/bmi_page.dart';
import './state_pattern/ui/order_page.dart';
import 'package:flutter/material.dart';
import 'abstract_factory/factory/light_factory.dart';
import 'abstract_factory/factory/dark_factory.dart';
import 'abstract_factory/factory/ui_factory.dart';
import 'abstract_factory/screens/home_page.dart' as af;
import 'abstract_factory/core/theme_selector.dart';
import 'builder_pattern/screens/home_page.dart' as bp;
import 'factory_method/screens/api_example_page.dart' as fm;
import 'prototype_pattern/screens/document_page.dart' as pt;
import 'singleton_pattern/screens/home_page.dart' as sg;
import 'adaptor_pattern/adaptor_homepage.dart' as ap;
import 'iterator_pattern/ui/product_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design Patterns')),
      body: ListView(
        children: [
          ExpansionTile(title: Text("Creational Patterns"),
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
          ListTile(
            title: const Text('Prototype Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const pt.DocumentPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Singleton Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const sg.HomePage()),
            ),
          ),
          const Divider(),
          ],
        ),
        ExpansionTile(title:Text("Structural Patterns"),
        children: [
         ListTile(
            title: const Text('Adapter Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ap.AdaptorHomepage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Bridge Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BridgePatternPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Composite Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FilePage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Decorator Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CoffeePage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Facade Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ComputerPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Flyweight Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FlyweightPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Proxy Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  ProxyPage()),
            ),
          ),
          const Divider(),
        
        ],

        ),
        ExpansionTile(title: Text("Behavioral Patterns"),
        children: [
          ListTile(
            title: const Text('Chain of Responsibility Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  OrderPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Command Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  CartPage()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Interpreter Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InterpreterUI()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Iterator Pattern'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductPage()),
            ),
          ),
          const Divider(),

            ListTile(
              title: const Text('Mediator Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  ChatPage()),
              ),
            ),
          const Divider(),

             ListTile(
              title: const Text('Memento Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  DrawingPage()),
              ),
            ),
            const Divider(),

             ListTile(
              title: const Text('Observer Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  ObserverPage()),
              ),
            ),
            const Divider(),

             ListTile(
              title: const Text('State Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  StatePage()),
              ),
            ),
           const Divider(),

           ListTile(
              title: const Text('Strategy Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  CheckoutPage()),
              ),
            ),
            const Divider(),

            ListTile(
              title: const Text('Template Method Pattern'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  BmiPage()),
              ),
            ),
        ],
        )
        ],
      )
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
