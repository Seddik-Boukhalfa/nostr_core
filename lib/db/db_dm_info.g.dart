// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_dm_info.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbDmSessionInfoCollection on Isar {
  IsarCollection<String, DbDmSessionInfo> get dbDmSessionInfos =>
      this.collection();
}

const DbDmSessionInfoSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbDmSessionInfo',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'ownPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'peerPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'readTime',
        type: IsarType.long,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, DbDmSessionInfo>(
    serialize: serializeDbDmSessionInfo,
    deserialize: deserializeDbDmSessionInfo,
    deserializeProperty: deserializeDbDmSessionInfoProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDbDmSessionInfo(IsarWriter writer, DbDmSessionInfo object) {
  IsarCore.writeString(writer, 1, object.id);
  IsarCore.writeString(writer, 2, object.ownPubkey);
  IsarCore.writeString(writer, 3, object.peerPubkey);
  IsarCore.writeLong(writer, 4, object.readTime);
  return Isar.fastHash(object.id);
}

@isarProtected
DbDmSessionInfo deserializeDbDmSessionInfo(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String _ownPubkey;
  _ownPubkey = IsarCore.readString(reader, 2) ?? '';
  final String _peerPubkey;
  _peerPubkey = IsarCore.readString(reader, 3) ?? '';
  final int _readTime;
  _readTime = IsarCore.readLong(reader, 4);
  final object = DbDmSessionInfo(
    id: _id,
    ownPubkey: _ownPubkey,
    peerPubkey: _peerPubkey,
    readTime: _readTime,
  );
  return object;
}

@isarProtected
dynamic deserializeDbDmSessionInfoProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readLong(reader, 4);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DbDmSessionInfoUpdate {
  bool call({
    required String id,
    String? ownPubkey,
    String? peerPubkey,
    int? readTime,
  });
}

class _DbDmSessionInfoUpdateImpl implements _DbDmSessionInfoUpdate {
  const _DbDmSessionInfoUpdateImpl(this.collection);

  final IsarCollection<String, DbDmSessionInfo> collection;

  @override
  bool call({
    required String id,
    Object? ownPubkey = ignore,
    Object? peerPubkey = ignore,
    Object? readTime = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (ownPubkey != ignore) 2: ownPubkey as String?,
          if (peerPubkey != ignore) 3: peerPubkey as String?,
          if (readTime != ignore) 4: readTime as int?,
        }) >
        0;
  }
}

sealed class _DbDmSessionInfoUpdateAll {
  int call({
    required List<String> id,
    String? ownPubkey,
    String? peerPubkey,
    int? readTime,
  });
}

class _DbDmSessionInfoUpdateAllImpl implements _DbDmSessionInfoUpdateAll {
  const _DbDmSessionInfoUpdateAllImpl(this.collection);

  final IsarCollection<String, DbDmSessionInfo> collection;

  @override
  int call({
    required List<String> id,
    Object? ownPubkey = ignore,
    Object? peerPubkey = ignore,
    Object? readTime = ignore,
  }) {
    return collection.updateProperties(id, {
      if (ownPubkey != ignore) 2: ownPubkey as String?,
      if (peerPubkey != ignore) 3: peerPubkey as String?,
      if (readTime != ignore) 4: readTime as int?,
    });
  }
}

extension DbDmSessionInfoUpdate on IsarCollection<String, DbDmSessionInfo> {
  _DbDmSessionInfoUpdate get update => _DbDmSessionInfoUpdateImpl(this);

  _DbDmSessionInfoUpdateAll get updateAll =>
      _DbDmSessionInfoUpdateAllImpl(this);
}

sealed class _DbDmSessionInfoQueryUpdate {
  int call({
    String? ownPubkey,
    String? peerPubkey,
    int? readTime,
  });
}

class _DbDmSessionInfoQueryUpdateImpl implements _DbDmSessionInfoQueryUpdate {
  const _DbDmSessionInfoQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbDmSessionInfo> query;
  final int? limit;

  @override
  int call({
    Object? ownPubkey = ignore,
    Object? peerPubkey = ignore,
    Object? readTime = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (ownPubkey != ignore) 2: ownPubkey as String?,
      if (peerPubkey != ignore) 3: peerPubkey as String?,
      if (readTime != ignore) 4: readTime as int?,
    });
  }
}

extension DbDmSessionInfoQueryUpdate on IsarQuery<DbDmSessionInfo> {
  _DbDmSessionInfoQueryUpdate get updateFirst =>
      _DbDmSessionInfoQueryUpdateImpl(this, limit: 1);

  _DbDmSessionInfoQueryUpdate get updateAll =>
      _DbDmSessionInfoQueryUpdateImpl(this);
}

class _DbDmSessionInfoQueryBuilderUpdateImpl
    implements _DbDmSessionInfoQueryUpdate {
  const _DbDmSessionInfoQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? ownPubkey = ignore,
    Object? peerPubkey = ignore,
    Object? readTime = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (ownPubkey != ignore) 2: ownPubkey as String?,
        if (peerPubkey != ignore) 3: peerPubkey as String?,
        if (readTime != ignore) 4: readTime as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension DbDmSessionInfoQueryBuilderUpdate
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QOperations> {
  _DbDmSessionInfoQueryUpdate get updateFirst =>
      _DbDmSessionInfoQueryBuilderUpdateImpl(this, limit: 1);

  _DbDmSessionInfoQueryUpdate get updateAll =>
      _DbDmSessionInfoQueryBuilderUpdateImpl(this);
}

extension DbDmSessionInfoQueryFilter
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QFilterCondition> {
  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idLessThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyGreaterThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyLessThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyLessThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyBetween(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyStartsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyEndsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      ownPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyGreaterThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyLessThan(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyLessThanOrEqualTo(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyBetween(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyStartsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyEndsWith(
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      peerPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterFilterCondition>
      readTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension DbDmSessionInfoQueryObject
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QFilterCondition> {}

extension DbDmSessionInfoQuerySortBy
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QSortBy> {
  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> sortByOwnPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      sortByOwnPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> sortByPeerPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      sortByPeerPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      sortByReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      sortByReadTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension DbDmSessionInfoQuerySortThenBy
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QSortThenBy> {
  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> thenByOwnPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      thenByOwnPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy> thenByPeerPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      thenByPeerPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      thenByReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterSortBy>
      thenByReadTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension DbDmSessionInfoQueryWhereDistinct
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QDistinct> {
  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterDistinct>
      distinctByOwnPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterDistinct>
      distinctByPeerPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QAfterDistinct>
      distinctByReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }
}

extension DbDmSessionInfoQueryProperty1
    on QueryBuilder<DbDmSessionInfo, DbDmSessionInfo, QProperty> {
  QueryBuilder<DbDmSessionInfo, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbDmSessionInfo, String, QAfterProperty> ownPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbDmSessionInfo, String, QAfterProperty> peerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbDmSessionInfo, int, QAfterProperty> readTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbDmSessionInfoQueryProperty2<R>
    on QueryBuilder<DbDmSessionInfo, R, QAfterProperty> {
  QueryBuilder<DbDmSessionInfo, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R, String), QAfterProperty>
      ownPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R, String), QAfterProperty>
      peerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R, int), QAfterProperty> readTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbDmSessionInfoQueryProperty3<R1, R2>
    on QueryBuilder<DbDmSessionInfo, (R1, R2), QAfterProperty> {
  QueryBuilder<DbDmSessionInfo, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R1, R2, String), QOperations>
      ownPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R1, R2, String), QOperations>
      peerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbDmSessionInfo, (R1, R2, int), QOperations> readTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
