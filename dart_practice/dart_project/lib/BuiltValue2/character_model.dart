library characters;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'character_model.g.dart';

abstract class Characters implements Built<Characters, CharactersBuilder> {

  String get name;
  int get id;
  String get species;

  Characters._();

  factory Characters([void Function(CharactersBuilder) updates]) = _$Characters;

  static Serializer<Characters> get serializer => _$charactersSerializer;
}