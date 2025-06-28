// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user_drafts.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbUserDraftsCollection on Isar {
  IsarCollection<String, DbUserDrafts> get dbUserDrafts => this.collection();
}

const DbUserDraftsSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbUserDrafts',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'pubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'data',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, DbUserDrafts>(
    serialize: serializeDbUserDrafts,
    deserialize: deserializeDbUserDrafts,
    deserializeProperty: deserializeDbUserDraftsProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDbUserDrafts(IsarWriter writer, DbUserDrafts object) {
  IsarCore.writeString(writer, 1, object.pubkey);
  IsarCore.writeString(writer, 2, object.data);
  IsarCore.writeString(writer, 3, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
DbUserDrafts deserializeDbUserDrafts(IsarReader reader) {
  final String _pubkey;
  _pubkey = IsarCore.readString(reader, 1) ?? '';
  final String _data;
  _data = IsarCore.readString(reader, 2) ?? '';
  final object = DbUserDrafts(
    pubkey: _pubkey,
    data: _data,
  );
  return object;
}

@isarProtected
dynamic deserializeDbUserDraftsProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DbUserDraftsUpdate {
  bool call({
    required String id,
    String? pubkey,
    String? data,
  });
}

class _DbUserDraftsUpdateImpl implements _DbUserDraftsUpdate {
  const _DbUserDraftsUpdateImpl(this.collection);

  final IsarCollection<String, DbUserDrafts> collection;

  @override
  bool call({
    required String id,
    Object? pubkey = ignore,
    Object? data = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (pubkey != ignore) 1: pubkey as String?,
          if (data != ignore) 2: data as String?,
        }) >
        0;
  }
}

sealed class _DbUserDraftsUpdateAll {
  int call({
    required List<String> id,
    String? pubkey,
    String? data,
  });
}

class _DbUserDraftsUpdateAllImpl implements _DbUserDraftsUpdateAll {
  const _DbUserDraftsUpdateAllImpl(this.collection);

  final IsarCollection<String, DbUserDrafts> collection;

  @override
  int call({
    required List<String> id,
    Object? pubkey = ignore,
    Object? data = ignore,
  }) {
    return collection.updateProperties(id, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (data != ignore) 2: data as String?,
    });
  }
}

extension DbUserDraftsUpdate on IsarCollection<String, DbUserDrafts> {
  _DbUserDraftsUpdate get update => _DbUserDraftsUpdateImpl(this);

  _DbUserDraftsUpdateAll get updateAll => _DbUserDraftsUpdateAllImpl(this);
}

sealed class _DbUserDraftsQueryUpdate {
  int call({
    String? pubkey,
    String? data,
  });
}

class _DbUserDraftsQueryUpdateImpl implements _DbUserDraftsQueryUpdate {
  const _DbUserDraftsQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbUserDrafts> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? data = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (data != ignore) 2: data as String?,
    });
  }
}

extension DbUserDraftsQueryUpdate on IsarQuery<DbUserDrafts> {
  _DbUserDraftsQueryUpdate get updateFirst =>
      _DbUserDraftsQueryUpdateImpl(this, limit: 1);

  _DbUserDraftsQueryUpdate get updateAll => _DbUserDraftsQueryUpdateImpl(this);
}

class _DbUserDraftsQueryBuilderUpdateImpl implements _DbUserDraftsQueryUpdate {
  const _DbUserDraftsQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbUserDrafts, DbUserDrafts, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? data = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (pubkey != ignore) 1: pubkey as String?,
        if (data != ignore) 2: data as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension DbUserDraftsQueryBuilderUpdate
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QOperations> {
  _DbUserDraftsQueryUpdate get updateFirst =>
      _DbUserDraftsQueryBuilderUpdateImpl(this, limit: 1);

  _DbUserDraftsQueryUpdate get updateAll =>
      _DbUserDraftsQueryBuilderUpdateImpl(this);
}

extension DbUserDraftsQueryFilter
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QFilterCondition> {
  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> pubkeyEqualTo(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyGreaterThan(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyLessThan(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> pubkeyBetween(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyStartsWith(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyEndsWith(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> pubkeyMatches(
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

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      pubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> dataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }
}

extension DbUserDraftsQueryObject
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QFilterCondition> {}

extension DbUserDraftsQuerySortBy
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QSortBy> {
  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortByDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension DbUserDraftsQuerySortThenBy
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QSortThenBy> {
  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenByDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserDraftsQueryWhereDistinct
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QDistinct> {
  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterDistinct> distinctByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserDrafts, DbUserDrafts, QAfterDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserDraftsQueryProperty1
    on QueryBuilder<DbUserDrafts, DbUserDrafts, QProperty> {
  QueryBuilder<DbUserDrafts, String, QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserDrafts, String, QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserDrafts, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DbUserDraftsQueryProperty2<R>
    on QueryBuilder<DbUserDrafts, R, QAfterProperty> {
  QueryBuilder<DbUserDrafts, (R, String), QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserDrafts, (R, String), QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserDrafts, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DbUserDraftsQueryProperty3<R1, R2>
    on QueryBuilder<DbUserDrafts, (R1, R2), QAfterProperty> {
  QueryBuilder<DbUserDrafts, (R1, R2, String), QOperations> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserDrafts, (R1, R2, String), QOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserDrafts, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
