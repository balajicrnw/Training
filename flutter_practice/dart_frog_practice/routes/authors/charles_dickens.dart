import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final books = [
    'Oliver Twist',
    'A Christmas Carol',
    'David Copperfield',
    'Great Expectations',
    'Bleak House',
  ];

  return Response(
    body: jsonEncode({
      'author': 'Charles Dickens',
      'country': 'England',
      'genre': 'Classic Literature',
      'books': books,
    }),
    headers: {
      'content-type': 'application/json',
    },
  );
}
