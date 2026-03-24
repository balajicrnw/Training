import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctors_door/core/cart_provider.dart';
import 'package:doctors_door/shared/medicine_model.dart';

void main() {
  group('CartProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    final mockMedicine = MedicineModel((b) => b
      ..id = '1'
      ..name = 'Test Medicine'
      ..type = 'Tablet'
      ..price = 10.0
      ..description = 'Test'
      ..imageUrl = 'test.jpg'
    );

    test('Initial state is empty list', () {
      expect(container.read(cartProvider), []);
    });

    test('Adding medicine to cart', () {
      container.read(cartProvider.notifier).addToCart(mockMedicine);
      expect(container.read(cartProvider), [mockMedicine]);
    });

    test('Adding duplicate medicine does not add again', () {
      container.read(cartProvider.notifier).addToCart(mockMedicine);
      container.read(cartProvider.notifier).addToCart(mockMedicine);
      expect(container.read(cartProvider).length, 1);
    });

    test('Removing medicine from cart', () {
      container.read(cartProvider.notifier).addToCart(mockMedicine);
      container.read(cartProvider.notifier).removeFromCart('1');
      expect(container.read(cartProvider), []);
    });

    test('Clearing cart', () {
      container.read(cartProvider.notifier).addToCart(mockMedicine);
      container.read(cartProvider.notifier).clearCart();
      expect(container.read(cartProvider), []);
    });
  });
}
