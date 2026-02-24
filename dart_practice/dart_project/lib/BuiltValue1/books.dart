library books;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializer1.dart';

part 'books.g.dart';


abstract class Books implements Built<Books,BooksBuilder>{
  int get id;
  String get Title;
  String get Publisher;
  int get Year;
  int get Pages;

  Books._();

  factory Books([void Function(BooksBuilder) updates]) = _$Books;

  static Serializer<Books> get serializer => _$booksSerializer;

}