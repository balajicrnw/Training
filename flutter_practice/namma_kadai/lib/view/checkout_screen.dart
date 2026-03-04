import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../model/cart_item.dart';
import '../viewmodel/view_model.dart'; // Import your AppNotifier / providers

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(appViewModelProvider);
    final orders = ordersState.orders;

    if (ordersState.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order History')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(ordersState.errorMessage!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(appViewModelProvider.notifier).loadOrders(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order History')),
        body: RefreshIndicator(
          onRefresh: () => ref.read(appViewModelProvider.notifier).loadOrders(),
          child: Stack(
            children: [
              ListView(),
              const Center(child: Text('No orders placed yet.')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(appViewModelProvider.notifier).loadOrders(),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(  
                  'Order #${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Total: ₹${order.totalAmount.toStringAsFixed(2)}\n${DateFormat('dd MMM yyyy, hh:mm a').format(order.dateTime.toLocal())}',
                ),
                children: order.items.map((CartItem item) {
                  return ListTile(
                    dense: true,
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('₹${item.price.toStringAsFixed(2)} x ${item.quantity}'),
                    trailing: Text(
                      '₹${item.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}