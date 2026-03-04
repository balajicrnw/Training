import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/view_model.dart';
import '../core/extensions/widget_ref_extension.dart';
import '../core/routing/route_names.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.products.isEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo, Colors.deepPurple],
            ),
          ),
        ),
        title: ref.watch(authStateProvider).when(
              data: (user) {
                if (user == null) {
                  return const Text(
                    'Namma Kadai',
                    style: TextStyle(color: Colors.white),
                  );
                }
                final name = ref.userData?['name'];
                return Text(
                  name != null ? 'Hi $name' : 'Hi User',
                  style: const TextStyle(color: Colors.white),
                );
              },
              loading: () => const Text('Namma Kadai',
                  style: TextStyle(color: Colors.white)),
              error: (err, stack) =>
                  const Text('Error', style: TextStyle(color: Colors.white)),
            ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined, color: Colors.white),
            onPressed: () => context.pushNamed(RouteNames.checkout),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
                onPressed: () => context.pushNamed(RouteNames.cart),
              ),
              if (ref.cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${ref.cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          ref.watch(authStateProvider).when(
                data: (user) => IconButton(
                  icon: Icon(user != null ? Icons.logout : Icons.login,
                      color: Colors.white),
                  onPressed: () {
                    if (user != null) {
                      ref.read(appViewModelProvider.notifier).logout();
                    } else {
                      context.pushNamed(RouteNames.login);
                    }
                  },
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
          const SizedBox(width: 8),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: ref.products.length,
                itemBuilder: (context, index) {
                  final product = ref.products[index];
                  return GestureDetector(
                    onTap: () => context.pushNamed(
                      RouteNames.productDetail,
                      pathParameters: {'id': product.id.toString()},
                      extra: product,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(24)),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.grey[50],
                                    padding: const EdgeInsets.all(16),
                                    child: Hero(
                                      tag: 'product_${product.id}',
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.image_not_supported,
                                                size: 50, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${product.price}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    // Removed Icons.add as requested
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}