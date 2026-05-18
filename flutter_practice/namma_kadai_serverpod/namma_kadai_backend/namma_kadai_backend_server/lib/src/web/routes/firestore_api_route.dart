import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart' as shared;
import '../../namma_kadai_services/api_impl.dart';

class FirestoreApiRoute extends WidgetRoute {
  final api = ApiImpl();

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final rawPath = request.url.path;
    final path = rawPath.startsWith('/') ? rawPath : '/$rawPath';
    
    try {
      // POST methods
      if (request.method == Method.post) {
        if (path == '/seedProducts') {
          await api.seedProducts();
          return JsonWidget(object: {'status': 'ok'});
        }

        final bodyString = await (request.body as dynamic).asJson(); // Using dynamic as workaround for relic_core API
        final data = bodyString is String ? jsonDecode(bodyString) : bodyString;

        if (path == '/createProduct' || path == '/updateProduct') {
          await api.saveProduct(data);
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/deleteProduct') {
          await api.deleteProduct(data['id']);
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/updateCartQuantity') {
          api.currentUserId = data['userId'] ?? 'mock_user';
          await api.updateCartQuantity(data['productId'], data['quantity']);
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/removeFromCart') {
          api.currentUserId = data['userId'] ?? 'mock_user';
          await api.removeFromCart(data['productId']);
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/clearCart') {
          api.currentUserId = data['userId'] ?? 'mock_user';
          await api.clearCart();
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/saveUserData') {
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/saveOrder') {
          return JsonWidget(object: {'status': 'ok'});
        }

        if (path == '/addToCart') {
          api.currentUserId = data['userId'] ?? 'mock_user';
          return JsonWidget(object: {'status': 'ok'});
        }
      }

      // GET methods
      if (request.method == Method.get) {
        if (path == '/seedProducts') {
          await api.seedProducts();
          return JsonWidget(object: {'status': 'ok (via GET)'});
        }

        if (path == '/getProducts') {
          final products = await api.getProducts();
          return JsonWidget(object: products.map((p) => shared.serializers.serializeWith(shared.Product.serializer, p)).toList());
        }

        if (path == '/getUserData') {
          final userId = request.url.queryParameters['userId'];
          if (userId == null) return JsonWidget(object: {'error': 'userId required'});
          final user = await api.getUserData(userId).first;
          return JsonWidget(object: user != null ? shared.serializers.serializeWith(shared.UserModel.serializer, user) : null);
        }

        if (path == '/getCartItems') {
          api.currentUserId = request.url.queryParameters['userId'] ?? 'mock_user';
          final items = await api.getCartItems();
          return JsonWidget(object: items.map((i) => shared.serializers.serializeWith(shared.CartItem.serializer, i)).toList());
        }

        if (path == '/getOrders') {
          final userId = request.url.queryParameters['userId'];
          if (userId == null) return JsonWidget(object: {'error': 'userId required'});
          final orders = await api.getOrders(userId).first;
          return JsonWidget(object: orders.map((o) => shared.serializers.serializeWith(shared.Order.serializer, o)).toList());
        }
      }

      return JsonWidget(object: {'error': 'Not found', 'path': path, 'method': request.method.toString()});
    } catch (e) {
      session.log('Error in FirestoreApiRoute: $e');
      return JsonWidget(object: {'error': e.toString()});
    }
  }
}
