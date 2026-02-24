// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Books> _$booksSerializer = _$BooksSerializer();

class _$BooksSerializer implements StructuredSerializer<Books> {
  @override
  final Iterable<Type> types = const [Books, _$Books];
  @override
  final String wireName = 'Books';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Books object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'Title',
      serializers.serialize(
        object.Title,
        specifiedType: const FullType(String),
      ),
      'Publisher',
      serializers.serialize(
        object.Publisher,
        specifiedType: const FullType(String),
      ),
      'Year',
      serializers.serialize(object.Year, specifiedType: const FullType(int)),
      'Pages',
      serializers.serialize(object.Pages, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Books deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BooksBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'Title':
          result.Title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'Publisher':
          result.Publisher =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'Year':
          result.Year =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'Pages':
          result.Pages =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Books extends Books {
  @override
  final int id;
  @override
  final String Title;
  @override
  final String Publisher;
  @override
  final int Year;
  @override
  final int Pages;

  factory _$Books([void Function(BooksBuilder)? updates]) =>
      (BooksBuilder()..update(updates))._build();

  _$Books._({
    required this.id,
    required this.Title,
    required this.Publisher,
    required this.Year,
    required this.Pages,
  }) : super._();
  @override
  Books rebuild(void Function(BooksBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BooksBuilder toBuilder() => BooksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Books &&
        id == other.id &&
        Title == other.Title &&
        Publisher == other.Publisher &&
        Year == other.Year &&
        Pages == other.Pages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, Title.hashCode);
    _$hash = $jc(_$hash, Publisher.hashCode);
    _$hash = $jc(_$hash, Year.hashCode);
    _$hash = $jc(_$hash, Pages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Books')
          ..add('id', id)
          ..add('Title', Title)
          ..add('Publisher', Publisher)
          ..add('Year', Year)
          ..add('Pages', Pages))
        .toString();
  }
}

class BooksBuilder implements Builder<Books, BooksBuilder> {
  _$Books? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _Title;
  String? get Title => _$this._Title;
  set Title(String? Title) => _$this._Title = Title;

  String? _Publisher;
  String? get Publisher => _$this._Publisher;
  set Publisher(String? Publisher) => _$this._Publisher = Publisher;

  int? _Year;
  int? get Year => _$this._Year;
  set Year(int? Year) => _$this._Year = Year;

  int? _Pages;
  int? get Pages => _$this._Pages;
  set Pages(int? Pages) => _$this._Pages = Pages;

  BooksBuilder();

  BooksBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _Title = $v.Title;
      _Publisher = $v.Publisher;
      _Year = $v.Year;
      _Pages = $v.Pages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Books other) {
    _$v = other as _$Books;
  }

  @override
  void update(void Function(BooksBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Books build() => _build();

  _$Books _build() {
    final _$result =
        _$v ??
        _$Books._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Books', 'id'),
          Title: BuiltValueNullFieldError.checkNotNull(
            Title,
            r'Books',
            'Title',
          ),
          Publisher: BuiltValueNullFieldError.checkNotNull(
            Publisher,
            r'Books',
            'Publisher',
          ),
          Year: BuiltValueNullFieldError.checkNotNull(Year, r'Books', 'Year'),
          Pages: BuiltValueNullFieldError.checkNotNull(
            Pages,
            r'Books',
            'Pages',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
