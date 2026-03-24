import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/pharmacy_service.dart';
import '../../core/cart_provider.dart';
import '../../shared/medicine_model.dart';

class PharmacyPage extends ConsumerStatefulWidget {
  const PharmacyPage({super.key});

  @override
  ConsumerState<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends ConsumerState<PharmacyPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<MedicineModel> _medicines;

  @override
  void initState() {
    super.initState();
    _medicines = PharmacyService.getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pharmacy"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Badge(
              label: Text(cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _medicines.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_medicines[index], animation, index);
        },
      ),
    );
  }

  Widget _buildItem(MedicineModel medicine, Animation<double> animation, int index) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOut))),
      child: FadeTransition(
        opacity: animation,
        child: Dismissible(
          key: Key(medicine.id),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.green.withOpacity(0.8),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Row(
              children: [
                Icon(Icons.add_shopping_cart, color: Colors.white),
                SizedBox(width: 8),
                Text("Add to List", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            _addToCart(medicine);
            return false; // Don't actually remove from the pharmacy list
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  medicine.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${medicine.type} - \$${medicine.price}"),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Show details if needed
              },
            ),
          ),
        ),
      ),
    );
  }

  void _addToCart(MedicineModel medicine) {
    ref.read(cartProvider.notifier).addToCart(medicine);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Added ${medicine.name} to cart"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            ref.read(cartProvider.notifier).removeFromCart(medicine.id);
          },
        ),
      ),
    );
    // Note: We don't remove from the main medicines list, just add to cart.
    // Resetting the Dismissible state:
    setState(() {
       // Since it's dismissed, it won't show unless we rebuild or handle it.
       // However, Dismissible usually stays gone unless we provide a way to put it back.
       // For "Add to Cart", maybe we don't want it to disappear permanently.
       // Actually, the user said "slide to add to the list to buy". 
       // Often this means the item stays in the list but a copy goes to the cart.
    });
  }
}
