import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final books = [
    'Treasure Island',
    'Kidnapped',
    'Strange Case of Dr Jekyll and Mr Hyde',
    'The Black Arrow',
    'Catriona',
  ];

  return Response(
    body: jsonEncode({
      'author': 'Robert Louis Stevenson',
      'country': 'Scotland',
      'genre': 'Adventure Fiction',
      'books': books,
    }),
    headers: {
      'content-type': 'application/json',
    },
  );
}
