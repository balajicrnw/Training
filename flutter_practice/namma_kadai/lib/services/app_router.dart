import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai/model/product.dart';
import 'package:namma_kadai/view/cart_screen.dart';
import 'package:namma_kadai/view/checkout_screen.dart';
import 'package:namma_kadai/view/login_screen.dart';
import 'package:namma_kadai/view/product_detail_screen.dart';
import 'package:namma_kadai/view/product_list_screen.dart';
import 'package:namma_kadai/view/register_screen.dart';
import 'package:namma_kadai/viewmodel/view_model.dart';

import '../core/routing/route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.home,
    refreshListenable: GoRouterRefreshStream(ref.read(authStateProvider.stream)),
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authState.asData?.value != null;
      final bool onLoginPage = state.matchedLocation == RouteNames.login;
      final bool onRegisterPage = state.matchedLocation == RouteNames.register;
      final bool onHomePage = state.matchedLocation == RouteNames.home;
      final bool onProductDetailPage = state.matchedLocation.startsWith('/product/');

      if (!loggedIn && !onLoginPage && !onRegisterPage && !onHomePage && !onProductDetailPage) {
        return RouteNames.login;
      }

     
      if (loggedIn && (onLoginPage || onRegisterPage)) {
        return RouteNames.home;
      }

      return null; 
    },
    routes: [
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        name: RouteNames.productDetail,
        builder: (context, state) {
          
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.cart,
        name: RouteNames.cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: RouteNames.checkout,
        name: RouteNames.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
});


class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}