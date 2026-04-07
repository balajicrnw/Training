import 'package:flutter/material.dart';
import '../models/bullet_type.dart';

class BulletFactory {
  static final Map<String, BulletType> _cache = {};

  static BulletType getBullet(Color color, double size) {
    String key = "$color-$size";

    if (!_cache.containsKey(key)) {
      _cache[key] = BulletType(color, size);
      print("Created NEW BulletType");
    } else {
      print("Reused BulletType");
    }

    return _cache[key]!;
  }
}