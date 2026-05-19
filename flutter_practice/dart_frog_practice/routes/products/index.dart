import 'package:dart_frog/dart_frog.dart';
import 'data.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: {
      'products': products,
    },
  );
}
