import 'dart:convert';
import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart' as shared;
import '../../namma_kadai_services/api_impl.dart';

class FirestoreApiRoute extends Route {
  final api = ApiImpl();
  late final Future<void> _initFuture;

  FirestoreApiRoute._internal()
    : super(methods: {Method.get, Method.post, Method.options}) {
    _initFuture = api.init();
  }

  factory FirestoreApiRoute() => FirestoreApiRoute._internal();

  @override
  Future<Result> handleCall(Session session, Request request) async {
    await _initFuture;
    final corsHeaders = Headers.fromMap({
      'Access-Control-Allow-Origin': ['*'],
      'Access-Control-Allow-Methods': ['GET, POST, PUT, DELETE, OPTIONS'],
      'Access-Control-Allow-Headers': [
        'Origin, Content-Type, Accept, Authorization',
      ],
    });

    final responseHeaders = Headers.fromMap({
      'Access-Control-Allow-Origin': ['*'],
      'Access-Control-Allow-Methods': ['GET, POST, PUT, DELETE, OPTIONS'],
      'Access-Control-Allow-Headers': [
        'Origin, Content-Type, Accept, Authorization',
      ],
      'Content-Type': ['application/json'],
    });

    if (request.method == Method.options) {
      return Response(
        HttpStatus.ok,
        headers: corsHeaders,
        body: Body.empty(),
      );
    }

    final rawPath = request.url.path;
    final path = rawPath.startsWith('/') ? rawPath : '/$rawPath';
    Object? jsonResponse;

    try {
      if (request.method == Method.post) {
        if (path == '/auth/signIn' ||
            path == '/auth/signUp' ||
            path == '/auth/signOut') {
          final bodyString = await request.readAsString();
          final data = bodyString.isNotEmpty
              ? jsonDecode(bodyString) as Map<String, dynamic>
              : <String, dynamic>{};

          if (path == '/auth/signIn') {
            final user = await api.signIn(
              data['email'] as String? ?? '',
              data['password'] as String? ?? '',
            );
            if (user != null) {
              jsonResponse = {'id': user.id, 'email': user.email};
            } else {
              jsonResponse = {'error': 'invalid-credential'};
            }
          } else if (path == '/auth/signUp') {
            final user = await api.signUp(
              data['email'] as String? ?? '',
              data['password'] as String? ?? '',
              name: data['name'] as String?,
            );
            jsonResponse = {'id': user!.id, 'email': user.email};
          } else if (path == '/auth/signOut') {
            jsonResponse = {'status': 'ok'};
          }
        } else if (path == '/seedProducts') {
          await api.seedProducts();
          jsonResponse = {'status': 'ok'};
        } else {
          final bodyString = await request.readAsString();
          final data = bodyString.isNotEmpty
              ? jsonDecode(bodyString) as Map<String, dynamic>
              : <String, dynamic>{};

          if (path == '/createProduct' || path == '/updateProduct') {
            await api.saveProduct(data);
            jsonResponse = {'status': 'ok'};
          } else if (path == '/deleteProduct') {
            await api.deleteProduct(data['id']);
            jsonResponse = {'status': 'ok'};
          } else if (path == '/updateCartQuantity') {
            api.currentUserId = data['userId'] ?? 'mock_user';
            await api.updateCartQuantity(data['productId'], data['quantity']);
            jsonResponse = {'status': 'ok'};
          } else if (path == '/removeFromCart') {
            api.currentUserId = data['userId'] ?? 'mock_user';
            await api.removeFromCart(data['productId']);
            jsonResponse = {'status': 'ok'};
          } else if (path == '/clearCart') {
            api.currentUserId = data['userId'] ?? 'mock_user';
            await api.clearCart();
            jsonResponse = {'status': 'ok'};
          } else if (path == '/saveUserData') {
            final authUser = shared.AuthUser(
              (b) => b
                ..id = (data['userId'] as String?) ?? ''
                ..email = (data['email'] as String?) ?? '',
            );
            await api.saveUserData(
              authUser,
              name: data['name'] as String?,
              gender: data['gender'] as String?,
              profileImageUrl: data['profileImageUrl'] as String?,
            );
            jsonResponse = {'status': 'ok'};
          } else if (path == '/saveOrder') {
            final order = shared.serializers.deserializeWith(
              shared.Order.serializer,
              data,
            );
            if (order != null) {
              await api.saveOrder(order);
              jsonResponse = {'status': 'ok'};
            } else {
              jsonResponse = {'error': 'Invalid order data'};
            }
          } else if (path == '/addToCart') {
            api.currentUserId = data['userId'] as String? ?? 'mock_user';
            final cartItem = shared.serializers.deserializeWith(
              shared.CartItem.serializer,
              data,
            );
            if (cartItem != null) {
              await api.addToCart(cartItem);
              jsonResponse = {'status': 'ok'};
            } else {
              jsonResponse = {'error': 'Invalid cart item data'};
            }
          }
        }
      } else if (request.method == Method.get) {
        if (path == '/seedProducts') {
          await api.seedProducts();
          jsonResponse = {'status': 'ok (via GET)'};
        } else if (path == '/getProducts') {
          final products = await api.getProducts();
          jsonResponse = products
              .map(
                (p) => shared.serializers.serializeWith(
                  shared.Product.serializer,
                  p,
                ),
              )
              .toList();
        } else if (path == '/getUserData') {
          final userId = request.url.queryParameters['userId'];
          if (userId == null) {
            jsonResponse = {'error': 'userId required'};
          } else {
            final user = await api.getUserData(userId).first;
            jsonResponse = user != null
                ? shared.serializers.serializeWith(
                    shared.UserModel.serializer,
                    user,
                  )
                : null;
          }
        } else if (path == '/getCartItems') {
          api.currentUserId =
              request.url.queryParameters['userId'] ?? 'mock_user';
          final items = await api.getCartItems();
          jsonResponse = items
              .map(
                (i) => shared.serializers.serializeWith(
                  shared.CartItem.serializer,
                  i,
                ),
              )
              .toList();
        } else if (path == '/getOrders') {
          final userId = request.url.queryParameters['userId'];
          if (userId == null) {
            jsonResponse = {'error': 'userId required'};
          } else {
            final orders = await api.getOrders(userId).first;
            jsonResponse = orders
                .map(
                  (o) => shared.serializers.serializeWith(
                    shared.Order.serializer,
                    o,
                  ),
                )
                .toList();
          }
        }
      }

      if (jsonResponse != null) {
        return Response(
          HttpStatus.ok,
          headers: responseHeaders,
          body: Body.fromString(jsonEncode(jsonResponse)),
        );
      } else {
        return Response(
          HttpStatus.notFound,
          headers: responseHeaders,
          body: Body.fromString(
            jsonEncode({
              'error': 'Not found',
              'path': path,
              'method': request.method.toString(),
            }),
          ),
        );
      }
    } catch (e) {
      session.log('Error in FirestoreApiRoute: $e');
      return Response(
        HttpStatus.internalServerError,
        headers: responseHeaders,
        body: Body.fromString(jsonEncode({'error': e.toString()})),
      );
    }
  }
}
