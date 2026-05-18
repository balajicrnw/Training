import 'dart:io';
import 'package:serverpod/serverpod.dart';

class CorsRoute extends Route {
  @override
  Set<Method> get methods => {
    Method.options,
  };

  @override
  Future<Result> handleCall(
    Session session,
    Request request,
  ) async {
    return Response(
      HttpStatus.ok,
      headers: Headers.fromMap({
        'Access-Control-Allow-Origin': ['*'],
        'Access-Control-Allow-Methods': ['GET, POST, PUT, DELETE, OPTIONS'],
        'Access-Control-Allow-Headers': [
          'Origin, Content-Type, Accept, Authorization',
        ],
      }),
      body: Body.empty(),
    );
  }
}
