library character;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'character.g.dart';

abstract class Character implements Built<Character, CharacterBuilder> {

  String get fullName;
  String get nickname;
  String get hogwartsHouse;
  String get interpretedBy;
  BuiltList<String> get children;
  String get image;
  String get birthdate;
  int get index;

  Character._();

  factory Character([void Function(CharacterBuilder) updates]) = _$Character;

  static Serializer<Character> get serializer => _$characterSerializer;
}