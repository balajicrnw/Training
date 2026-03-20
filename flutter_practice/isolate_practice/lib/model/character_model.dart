library character_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'character_model.g.dart';

abstract class CharacterModel
    implements Built<CharacterModel, CharacterModelBuilder> {

  String get name;
  String get role;
  String get gender;

  CharacterModel._();

  factory CharacterModel([void Function(CharacterModelBuilder) updates]) =_$CharacterModel;

  static Serializer<CharacterModel> get serializer => _$characterModelSerializer;
}