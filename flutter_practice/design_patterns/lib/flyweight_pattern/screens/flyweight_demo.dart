import 'package:flutter/material.dart';
import '../models/bullet.dart';
import '../factory/bullet_factory.dart';
import '../widgets/bullet_widget.dart';

class FlyweightPage extends StatefulWidget {
  const FlyweightPage({super.key});

  @override
  State<FlyweightPage> createState() => _FlyweightPageState();
}

class _FlyweightPageState extends State<FlyweightPage> {
  List<Bullet> bullets = [];

  void spawnBullet() {
    final type = BulletFactory.getBullet(Colors.red, 10);

    setState(() {
      bullets.add(
        Bullet(
          (bullets.length * 20) % 300,
          (bullets.length * 15) % 500,
          type,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flyweight Demo")),
      body: Stack(
        children: bullets.map((b) => BulletWidget(bullet: b)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: spawnBullet,
        child: const Icon(Icons.add),
      ),
    );
  }
}