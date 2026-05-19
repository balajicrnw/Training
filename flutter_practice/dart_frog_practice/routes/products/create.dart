import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import 'data.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: 'Only POST allowed',
    );
  }

  final body = await context.request.body();

  final data = jsonDecode(body) as Map<String, dynamic>;

  final newProduct = {
    'id': products.length + 1,
    'name': data['name'],
    'price': data['price'],
  };

  products.add(newProduct);

  return Response.json(
    body: {
      'message': 'Product added successfully',
      'product': newProduct,
    },
  );
}
