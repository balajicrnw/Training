import 'package:flutter/material.dart';

class Plan {
  final int price;
  final String validity;
  final String data;
  final Widget? addOns;
  final String? specialTag;

  const Plan({
    required this.price,
    required this.validity,
    required this.data,
    this.addOns,
    this.specialTag,
  });
}
