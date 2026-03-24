import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/medicine_model.dart';

final cartProvider = NotifierProvider<CartNotifier, List<MedicineModel>>(() {
  return CartNotifier();
});

class CartNotifier extends Notifier<List<MedicineModel>> {
  @override
  List<MedicineModel> build() {
    return [];
  }

  void addToCart(MedicineModel medicine) {
    if (!state.any((m) => m.id == medicine.id)) {
      state = [...state, medicine];
    }
  }

  void removeFromCart(String id) {
    state = state.where((m) => m.id != id).toList();
  }

  void clearCart() {
    state = [];
  }
}
