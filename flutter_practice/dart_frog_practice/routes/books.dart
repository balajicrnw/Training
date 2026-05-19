import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final books = [
    {
      'title': 'The Shining',
      'year': 1977,
      'genre': 'Horror',
      'pages': 447,
      'rating': 4.5,
    },
    {
      'title': 'IT',
      'year': 1986,
      'genre': 'Horror',
      'pages': 1138,
      'rating': 4.4,
    },
    {
      'title': 'Misery',
      'year': 1987,
      'genre': 'Psychological Horror',
      'pages': 320,
      'rating': 4.3,
    },
    {
      'title': 'The Green Mile',
      'year': 1996,
      'genre': 'Fantasy Drama',
      'pages': 400,
      'rating': 4.6,
    },
    {
      'title': 'Pet Sematary',
      'year': 1983,
      'genre': 'Horror',
      'pages': 374,
      'rating': 4.2,
    },
  ];

  return Response(
    body: jsonEncode({
      'author': 'Stephen King',
      'totalBooks': books.length,
      'books': books,
    }),
    headers: {
      'content-type': 'application/json',
    },
  );
}
