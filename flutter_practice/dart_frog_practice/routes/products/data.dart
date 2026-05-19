import 'package:dart_frog/dart_frog.dart';

final List<Map<String, dynamic>> products = [
  {
    'id': 1,
    'name': 'Laptop',
    'price': 55000,
  },
  {
    'id': 2,
    'name': 'Mouse',
    'price': 800,
  },
];

Response onRequest(RequestContext context) {
  return Response.json(
    body: {
      'message': 'Data route working',
    },
  );
}
