// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user_followers.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbUserFollowersCollection on Isar {
  IsarCollection<String, DbUserFollowers> get dbUserFollowers =>
      this.collection();
}

const DbUserFollowersSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbUserFollowers',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'pubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'followers',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'lastRefreshed',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, DbUserFollowers>(
    serialize: serializeDbUserFollowers,
    deserialize: deserializeDbUserFollowers,
    deserializeProperty: deserializeDbUserFollowersProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDbUserFollowers(IsarWriter writer, DbUserFollowers object) {
  IsarCore.writeString(writer, 1, object.pubkey);
  {
    final list = object.followers;
    final listWriter = IsarCore.beginList(writer, 2, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeLong(writer, 3, object.lastRefreshed);
  IsarCore.writeString(writer, 4, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
DbUserFollowers deserializeDbUserFollowers(IsarReader reader) {
  final String _pubkey;
  _pubkey = IsarCore.readString(reader, 1) ?? '';
  final List<String> _followers;
  {
    final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _followers = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _followers = list;
      }
    }
  }
  final int _lastRefreshed;
  _lastRefreshed = IsarCore.readLong(reader, 3);
  final object = DbUserFollowers(
    pubkey: _pubkey,
    followers: _followers,
    lastRefreshed: _lastRefreshed,
  );
  return object;
}

@isarProtected
dynamic deserializeDbUserFollowersProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      {
        final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <String>[];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 3:
      return IsarCore.readLong(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DbUserFollowersUpdate {
  bool call({
    required String id,
    String? pubkey,
    int? lastRefreshed,
  });
}

class _DbUserFollowersUpdateImpl implements _DbUserFollowersUpdate {
  const _DbUserFollowersUpdateImpl(this.collection);

  final IsarCollection<String, DbUserFollowers> collection;

  @override
  bool call({
    required String id,
    Object? pubkey = ignore,
    Object? lastRefreshed = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (pubkey != ignore) 1: pubkey as String?,
          if (lastRefreshed != ignore) 3: lastRefreshed as int?,
        }) >
        0;
  }
}

sealed class _DbUserFollowersUpdateAll {
  int call({
    required List<String> id,
    String? pubkey,
    int? lastRefreshed,
  });
}

class _DbUserFollowersUpdateAllImpl implements _DbUserFollowersUpdateAll {
  const _DbUserFollowersUpdateAllImpl(this.collection);

  final IsarCollection<String, DbUserFollowers> collection;

  @override
  int call({
    required List<String> id,
    Object? pubkey = ignore,
    Object? lastRefreshed = ignore,
  }) {
    return collection.updateProperties(id, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (lastRefreshed != ignore) 3: lastRefreshed as int?,
    });
  }
}

extension DbUserFollowersUpdate on IsarCollection<String, DbUserFollowers> {
  _DbUserFollowersUpdate get update => _DbUserFollowersUpdateImpl(this);

  _DbUserFollowersUpdateAll get updateAll =>
      _DbUserFollowersUpdateAllImpl(this);
}

sealed class _DbUserFollowersQueryUpdate {
  int call({
    String? pubkey,
    int? lastRefreshed,
  });
}

class _DbUserFollowersQueryUpdateImpl implements _DbUserFollowersQueryUpdate {
  const _DbUserFollowersQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbUserFollowers> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? lastRefreshed = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (pubkey != ignore) 1: pubkey as String?,
      if (lastRefreshed != ignore) 3: lastRefreshed as int?,
    });
  }
}

extension DbUserFollowersQueryUpdate on IsarQuery<DbUserFollowers> {
  _DbUserFollowersQueryUpdate get updateFirst =>
      _DbUserFollowersQueryUpdateImpl(this, limit: 1);

  _DbUserFollowersQueryUpdate get updateAll =>
      _DbUserFollowersQueryUpdateImpl(this);
}

class _DbUserFollowersQueryBuilderUpdateImpl
    implements _DbUserFollowersQueryUpdate {
  const _DbUserFollowersQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbUserFollowers, DbUserFollowers, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? pubkey = ignore,
    Object? lastRefreshed = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (pubkey != ignore) 1: pubkey as String?,
        if (lastRefreshed != ignore) 3: lastRefreshed as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension DbUserFollowersQueryBuilderUpdate
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QOperations> {
  _DbUserFollowersQueryUpdate get updateFirst =>
      _DbUserFollowersQueryBuilderUpdateImpl(this, limit: 1);

  _DbUserFollowersQueryUpdate get updateAll =>
      _DbUserFollowersQueryBuilderUpdateImpl(this);
}

extension DbUserFollowersQueryFilter
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QFilterCondition> {
  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementEqualTo(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementGreaterThan(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementGreaterThanOrEqualTo(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementLessThan(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementLessThanOrEqualTo(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementBetween(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementStartsWith(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementEndsWith(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersIsEmpty() {
    return not().followersIsNotEmpty();
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      followersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 2, value: null),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      lastRefreshedBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idLessThanOrEqualTo(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterFilterCondition>
      idIsNotEmpty() {
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

extension DbUserFollowersQueryObject
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QFilterCondition> {}

extension DbUserFollowersQuerySortBy
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QSortBy> {
  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> sortByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> sortByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy>
      sortByLastRefreshed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy>
      sortByLastRefreshedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> sortByIdDesc(
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

extension DbUserFollowersQuerySortThenBy
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QSortThenBy> {
  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> thenByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> thenByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy>
      thenByLastRefreshed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy>
      thenByLastRefreshedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DbUserFollowersQueryWhereDistinct
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QDistinct> {
  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterDistinct>
      distinctByPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterDistinct>
      distinctByFollowers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<DbUserFollowers, DbUserFollowers, QAfterDistinct>
      distinctByLastRefreshed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension DbUserFollowersQueryProperty1
    on QueryBuilder<DbUserFollowers, DbUserFollowers, QProperty> {
  QueryBuilder<DbUserFollowers, String, QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserFollowers, List<String>, QAfterProperty>
      followersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserFollowers, int, QAfterProperty> lastRefreshedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserFollowers, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbUserFollowersQueryProperty2<R>
    on QueryBuilder<DbUserFollowers, R, QAfterProperty> {
  QueryBuilder<DbUserFollowers, (R, String), QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserFollowers, (R, List<String>), QAfterProperty>
      followersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserFollowers, (R, int), QAfterProperty>
      lastRefreshedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserFollowers, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbUserFollowersQueryProperty3<R1, R2>
    on QueryBuilder<DbUserFollowers, (R1, R2), QAfterProperty> {
  QueryBuilder<DbUserFollowers, (R1, R2, String), QOperations>
      pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbUserFollowers, (R1, R2, List<String>), QOperations>
      followersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbUserFollowers, (R1, R2, int), QOperations>
      lastRefreshedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbUserFollowers, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
