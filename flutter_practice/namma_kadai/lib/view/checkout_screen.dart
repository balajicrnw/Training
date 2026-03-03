import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../model/cart_item.dart';
import '../viewmodel/view_model.dart';
import '../core/extensions/widget_ref_extension.dart';
import '../core/routing/route_names.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ref.orders.isEmpty
          ? const Center(child: Text('No orders placed yet.'))
          : ListView.builder(
              itemCount: ref.orders.length,
              itemBuilder: (context, index) {
                final order = ref.orders[index];
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: ExpansionTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Text(
                      'Total: ₹${order.totalAmount.toString()} - ${DateFormat('dd MMM yyyy, hh:mm a').format(order.dateTime.toLocal())}',
                    ),
                    children: order.items.map((item) {
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('₹${item.price.toString()} x ${item.quantity}'),
                        trailing: Text('₹${item.total.toString()}'),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
