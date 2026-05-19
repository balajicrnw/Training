import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final books = [
    'War and Peace',
    'Anna Karenina',
    'The Death of Ivan Ilyich',
    'Resurrection',
    'Childhood',
  ];

  return Response(
    body: jsonEncode({
      'author': 'Leo Tolstoy',
      'country': 'Russia',
      'genre': 'Philosophical Fiction',
      'books': books,
    }),
    headers: {
      'content-type': 'application/json',
    },
  );
}
