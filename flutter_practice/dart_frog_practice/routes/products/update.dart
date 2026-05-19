import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import 'data.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.put) {
    return Response(
      statusCode: 405,
      body: 'Only PUT allowed',
    );
  }

  final body = await context.request.body();

  final data = jsonDecode(body) as Map<String, dynamic>;

  final int id = data['id'] as int;

  final index = products.indexWhere(
    (product) => product['id'] == id,
  );

  if (index == -1) {
    return Response.json(
      statusCode: 404,
      body: {
        'message': 'Product not found',
      },
    );
  }

  products[index]['name'] = data['name'];
  products[index]['price'] = data['price'];

  return Response.json(
    body: {
      'message': 'Product updated successfully',
      'product': products[index],
    },
  );
}
