import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:namma_kadai/main.dart';
import 'package:namma_kadai/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  patrolTest(
    'Full App Flow Integration Test with GoRouter',
    ($) async {

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseAuth.instance.signOut();

      FlutterError.onError = (details) {
        throw details.exception;
      };

      await $.pumpWidgetAndSettle(
        const ProviderScope(child: MyApp()),
      );

      await $('What would you like to buy today?')
          .waitUntilVisible();

      if ($(Icons.login).exists) {
        await $(Icons.login).tap();
      }

      await $.pumpAndSettle();

      await $('Welcome Back').waitUntilVisible();

      await $(TextFormField).at(0)
          .enterText('jameskidd123@gmail.com');

      await $(TextFormField).at(1)
          .enterText('Jameskidd');

      await $('Login').tap();
      await $.pumpAndSettle();

      await $(Icons.logout).waitUntilVisible(
        timeout: const Duration(seconds: 10),
      );

      await $(Image).first.tap();
      await $.pumpAndSettle();

      await $('Description').waitUntilVisible();

      await $('Add to Cart').tap();
      await $.pumpAndSettle();

      await $(SnackBar).waitUntilVisible(
        timeout: const Duration(seconds: 10),
      );

      await $(BackButton).tap();
      await $.pumpAndSettle();

      await $('What would you like to buy today?')
          .waitUntilVisible();

      await Future.delayed(const Duration(seconds: 5));

      await $(const ValueKey('cart_button'))
          .waitUntilVisible(
        timeout: const Duration(seconds: 10),
      );

      await $(const ValueKey('cart_button')).tap();

      await $.pumpAndSettle();

      await $('My Cart').waitUntilVisible(
        timeout: const Duration(seconds: 10),
      );

      
      await $('Place Order').tap();
      await $.pumpAndSettle();

      await $('Order History').waitUntilVisible(
        timeout: const Duration(seconds: 10),
      );
    },
  );
}