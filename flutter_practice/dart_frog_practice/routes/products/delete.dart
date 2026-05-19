import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import 'data.dart';

Future<Response> onRequest(RequestContext context) async {
  // Allow only DELETE
  if (context.request.method != HttpMethod.delete) {
    return Response(
      statusCode: 405,
      body: 'Only DELETE allowed',
    );
  }

  // Read body
  final body = await context.request.body();

  final data = jsonDecode(body) as Map<String, dynamic>;

  final int id = data['id'] as int;

  // Find product index
  final index = products.indexWhere(
    (product) => product['id'] == id,
  );

  // Product not found
  if (index == -1) {
    return Response.json(
      statusCode: 404,
      body: {
        'message': 'Product not found',
      },
    );
  }

  // Remove product
  final deletedProduct = products.removeAt(index);

  return Response.json(
    body: {
      'message': 'Product deleted successfully',
      'deletedProduct': deletedProduct,
    },
  );
}
