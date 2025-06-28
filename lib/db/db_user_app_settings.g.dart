// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user_app_settings.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbUserAppSettingsCollection on Isar {
  IsarCollection<String, DbUserAppSettings> get dbUserAppSettings =>
      this.collection();
}

const DbUserAppSettingsSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbUserAppSettings',
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
  converter: IsarObjectConverter<String, DbUserAppSettings>(
    serialize: serializeDbUserAppSettings,
    deserialize: deserializeDbUserAppSettings,
    deserializeProperty: deserializeDbUserAppSettingsProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDbUserAppSettings(IsarWriter writer, DbUserAppSettings object) {
  IsarCore.writeString(writer, 1, object.pubkey);
  IsarCore.writeString(writer, 2, object.data);
  IsarCore.writeString(writer, 3, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
DbUserAppSettings deserializeDbUserAppSettings(IsarReader reader) {
  final String _pubkey;
  _pubkey = IsarCore.readString(reader, 1) ?? '';
  final String _data;
  _data = IsarCore.readString(reader, 2) ?? '';
  final object = DbUserAppSettings(
    pubkey: _pubkey,
    data: _data,
  );
  return object;
}

@isarProtected
dynamic deserializeDbUserAppSettingsProp(IsarReader reader, int property) {
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

sealed class _DbUserAppSettingsUpdate {
  bool call({
    required String id,
    String? pubkey,
    String? data,
  });
}

class _DbUserAppSettingsUpdateImpl implements _DbUserAppSettingsUpdate {
  const _DbUserAppSettingsUpdateImpl(this.collection);

  final IsarCollection<String, DbUserAppSettings> collection;

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

sealed class _DbUserAppSettingsUpdateAll {
  int call({
    required List<String> id,
    String? pubkey,
    String? data,
  });
}

class _DbUserAppSettingsUpdateAllImpl implements _DbUserAppSettingsUpdateAll {
  const _DbUserAppSettingsUpdateAllImpl(this.collection);

  final IsarCollection<String, DbUserAppSettings> collection;

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

extension DbUserAppSettingsUpdate on IsarCollection<String, DbUserAppSettings> {
  _DbUserAppSettingsUpdate get update => _DbUserAppSettingsUpdateImpl(this);

  _DbUserAppSettingsUpdateAll get updateAll =>
      _DbUserAppSettingsUpdateAllImpl(this);
}

sealed class _DbUserAppSettingsQueryUpdate {
  int call({
    String? pubkey,
    String? data,
  });
}

class _DbUserAppSettingsQueryUpdateImpl
    implements _DbUserAppSettingsQueryUpdate {
  const _DbUserAppSettingsQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbUserAppSettings> query;
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

extension DbUserAppSettingsQueryUpdate on IsarQuery<DbUserAppSettings> {
  _DbUserAppSettingsQueryUpdate get updateFirst =>
      _DbUserAppSettingsQueryUpdateImpl(this, limit: 1);

  _DbUserAppSettingsQueryUpdate get updateAll =>
      _DbUserAppSettingsQueryUpdateImpl(this);
}

class _DbUserAppSettingsQueryBuilderUpdateImpl
    implements _DbUserAppSettingsQueryUpdate {
  const _DbUserAppSettingsQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbUserAppSettings, DbUserAppSettings, QOperations> query;
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

extension DbUserAppSettingsQueryBuilderUpdate
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QOperations> {
  _DbUserAppSettingsQueryUpdate get updateFirst =>
      _DbUserAppSettingsQueryBuilderUpdateImpl(this, limit: 1);

  _DbUserAppSettingsQueryUpdate get updateAll =>
      _DbUserAppSettingsQueryBuilderUpdateImpl(this);
}

extension DbUserAppSettingsQueryFilter
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QFilterCondition> {
  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      pubkeyEqualTo(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      pubkeyBetween(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      pubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataEqualTo(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataLessThan(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataBetween(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataEndsWith(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      dataMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterFilterCondition>
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

extension DbUserAppSettingsQueryObject
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QFilterCondition> {}

extension DbUserAppSettingsQuerySortBy
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QSortBy> {
  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> sortByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy>
      sortByPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> sortByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy>
      sortByDataDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> sortByIdDesc(
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

extension DbUserAppSettingsQuerySortThenBy
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QSortThenBy> {
  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> thenByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy>
      thenByPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> thenByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy>
      thenByDataDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserAppSettingsQueryWhereDistinct
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QDistinct> {
  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterDistinct>
      distinctByPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserAppSettings, DbUserAppSettings, QAfterDistinct>
      distinctByData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserAppSettingsQueryProperty1
    on QueryBuilder<DbUserAppSettings, DbUserAppSettings, QProperty> {
  QueryBuilder<DbUserAppSettings, String, QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserAppSettings, String, QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserAppSettings, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DbUserAppSettingsQueryProperty2<R>
    on QueryBuilder<DbUserAppSettings, R, QAfterProperty> {
  QueryBuilder<DbUserAppSettings, (R, String), QAfterProperty>
      pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserAppSettings, (R, String), QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserAppSettings, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DbUserAppSettingsQueryProperty3<R1, R2>
    on QueryBuilder<DbUserAppSettings, (R1, R2), QAfterProperty> {
  QueryBuilder<DbUserAppSettings, (R1, R2, String), QOperations>
      pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserAppSettings, (R1, R2, String), QOperations>
      dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserAppSettings, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
