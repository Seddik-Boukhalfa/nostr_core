// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user_wot.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbUserWotCollection on Isar {
  IsarCollection<String, DbUserWot> get dbUserWots => this.collection();
}

const DbUserWotSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbUserWot',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'pubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createdAt',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'wot',
        type: IsarType.objectList,
        target: 'WotEntry',
      ),
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, DbUserWot>(
    serialize: serializeDbUserWot,
    deserialize: deserializeDbUserWot,
    deserializeProperty: deserializeDbUserWotProp,
  ),
  embeddedSchemas: [WotEntrySchema],
);

@isarProtected
int serializeDbUserWot(IsarWriter writer, DbUserWot object) {
  IsarCore.writeString(writer, 1, object.pubkey);
  IsarCore.writeLong(writer, 2, object.createdAt);
  {
    final list = object.wot;
    final listWriter = IsarCore.beginList(writer, 3, list.length);
    for (var i = 0; i < list.length; i++) {
      {
        final value = list[i];
        final objectWriter = IsarCore.beginObject(listWriter, i);
        serializeWotEntry(objectWriter, value);
        IsarCore.endObject(listWriter, objectWriter);
      }
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeString(writer, 4, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
DbUserWot deserializeDbUserWot(IsarReader reader) {
  final String _pubkey;
  _pubkey = IsarCore.readString(reader, 1) ?? '';
  final int _createdAt;
  _createdAt = IsarCore.readLong(reader, 2);
  final List<WotEntry> _wot;
  {
    final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _wot = const <WotEntry>[];
      } else {
        final list = List<WotEntry>.filled(
            length,
            WotEntry(
              key: '',
              value: double.nan,
            ),
            growable: true);
        for (var i = 0; i < length; i++) {
          {
            final objectReader = IsarCore.readObject(reader, i);
            if (objectReader.isNull) {
              list[i] = WotEntry(
                key: '',
                value: double.nan,
              );
            } else {
              final embedded = deserializeWotEntry(objectReader);
              IsarCore.freeReader(objectReader);
              list[i] = embedded;
            }
          }
        }
        IsarCore.freeReader(reader);
        _wot = list;
      }
    }
  }
  final object = DbUserWot(
    pubkey: _pubkey,
    createdAt: _createdAt,
    wot: _wot,
  );
  return object;
}

@isarProtected
dynamic deserializeDbUserWotProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readLong(reader, 2);
    case 3:
      {
        final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <WotEntry>[];
          } else {
            final list = List<WotEntry>.filled(
                length,
                WotEntry(
                  key: '',
                  value: double.nan,
                ),
                growable: true);
            for (var i = 0; i < length; i++) {
              {
                final objectReader = IsarCore.readObject(reader, i);
                if (objectReader.isNull) {
                  list[i] = WotEntry(
                    key: '',
                    value: double.nan,
                  );
                } else {
                  final embedded = deserializeWotEntry(objectReader);
                  IsarCore.freeReader(objectReader);
                  list[i] = embedded;
                }
              }
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DbUserWotUpdate {
  bool call({
    required String id,
    String? pubkey,
    int? createdAt,
  });
}

class _DbUserWotUpdateImpl implements _DbUserWotUpdate {
  const _DbUserWotUpdateImpl(this.collection);

  final IsarCollection<String, DbUserWot> collection;

  @override
  bool call({
    required String id,
    Object? pubkey = ignore,
    Object? createdAt = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (pubkey != ignore) 1: pubkey as String?,
          if (createdAt != ignore) 2: createdAt as int?,
        }) >
        0;
  }
}

sealed class _DbUserWotUpdateAll {
  int call({
    required List<String> id,
    String? pubkey,
    int? createdAt,
  });
}

class _DbUserWotUpdateAllImpl implements _DbUserWotUpdateAll {
  const _DbUserWotUpdateAllImpl(this.collection);

  final IsarCollection<String, DbUserWot> collection;

  @override
  int call({
    required List<String> id,
    Object? pubkey = ignore,
    Object? createdAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (createdAt != ignore) 2: createdAt as int?,
    });
  }
}

extension DbUserWotUpdate on IsarCollection<String, DbUserWot> {
  _DbUserWotUpdate get update => _DbUserWotUpdateImpl(this);

  _DbUserWotUpdateAll get updateAll => _DbUserWotUpdateAllImpl(this);
}

sealed class _DbUserWotQueryUpdate {
  int call({
    String? pubkey,
    int? createdAt,
  });
}

class _DbUserWotQueryUpdateImpl implements _DbUserWotQueryUpdate {
  const _DbUserWotQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbUserWot> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? createdAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (createdAt != ignore) 2: createdAt as int?,
    });
  }
}

extension DbUserWotQueryUpdate on IsarQuery<DbUserWot> {
  _DbUserWotQueryUpdate get updateFirst =>
      _DbUserWotQueryUpdateImpl(this, limit: 1);

  _DbUserWotQueryUpdate get updateAll => _DbUserWotQueryUpdateImpl(this);
}

class _DbUserWotQueryBuilderUpdateImpl implements _DbUserWotQueryUpdate {
  const _DbUserWotQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbUserWot, DbUserWot, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? createdAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (pubkey != ignore) 1: pubkey as String?,
        if (createdAt != ignore) 2: createdAt as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension DbUserWotQueryBuilderUpdate
    on QueryBuilder<DbUserWot, DbUserWot, QOperations> {
  _DbUserWotQueryUpdate get updateFirst =>
      _DbUserWotQueryBuilderUpdateImpl(this, limit: 1);

  _DbUserWotQueryUpdate get updateAll => _DbUserWotQueryBuilderUpdateImpl(this);
}

extension DbUserWotQueryFilter
    on QueryBuilder<DbUserWot, DbUserWot, QFilterCondition> {
  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      pubkeyGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      pubkeyLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> pubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> createdAtEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      createdAtGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      createdAtGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> createdAtLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      createdAtLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> createdAtBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> wotIsEmpty() {
    return not().wotIsNotEmpty();
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> wotIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 3, value: null),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }
}

extension DbUserWotQueryObject
    on QueryBuilder<DbUserWot, DbUserWot, QFilterCondition> {}

extension DbUserWotQuerySortBy on QueryBuilder<DbUserWot, DbUserWot, QSortBy> {
  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension DbUserWotQuerySortThenBy
    on QueryBuilder<DbUserWot, DbUserWot, QSortThenBy> {
  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserWotQueryWhereDistinct
    on QueryBuilder<DbUserWot, DbUserWot, QDistinct> {
  QueryBuilder<DbUserWot, DbUserWot, QAfterDistinct> distinctByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserWot, DbUserWot, QAfterDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }
}

extension DbUserWotQueryProperty1
    on QueryBuilder<DbUserWot, DbUserWot, QProperty> {
  QueryBuilder<DbUserWot, String, QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserWot, int, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserWot, List<WotEntry>, QAfterProperty> wotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserWot, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbUserWotQueryProperty2<R>
    on QueryBuilder<DbUserWot, R, QAfterProperty> {
  QueryBuilder<DbUserWot, (R, String), QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserWot, (R, int), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserWot, (R, List<WotEntry>), QAfterProperty> wotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserWot, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbUserWotQueryProperty3<R1, R2>
    on QueryBuilder<DbUserWot, (R1, R2), QAfterProperty> {
  QueryBuilder<DbUserWot, (R1, R2, String), QOperations> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserWot, (R1, R2, int), QOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserWot, (R1, R2, List<WotEntry>), QOperations> wotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserWot, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

// **************************************************************************
// _IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

const WotEntrySchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'WotEntry',
    embedded: true,
    properties: [
      IsarPropertySchema(
        name: 'key',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'value',
        type: IsarType.double,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<void, WotEntry>(
    serialize: serializeWotEntry,
    deserialize: deserializeWotEntry,
  ),
);

@isarProtected
int serializeWotEntry(IsarWriter writer, WotEntry object) {
  IsarCore.writeString(writer, 1, object.key);
  IsarCore.writeDouble(writer, 2, object.value);
  return 0;
}

@isarProtected
WotEntry deserializeWotEntry(IsarReader reader) {
  final String _key;
  _key = IsarCore.readString(reader, 1) ?? '';
  final double _value;
  _value = IsarCore.readDouble(reader, 2);
  final object = WotEntry(
    key: _key,
    value: _value,
  );
  return object;
}

extension WotEntryQueryFilter
    on QueryBuilder<WotEntry, WotEntry, QFilterCondition> {
  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition>
      keyGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> valueEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> valueGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition>
      valueGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> valueLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition>
      valueLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WotEntry, WotEntry, QAfterFilterCondition> valueBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }
}

extension WotEntryQueryObject
    on QueryBuilder<WotEntry, WotEntry, QFilterCondition> {}
