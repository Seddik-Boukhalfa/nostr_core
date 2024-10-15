// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_event_stats.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDbEventStatsCollection on Isar {
  IsarCollection<String, DbEventStats> get dbEventStats => this.collection();
}

const DbEventStatsSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DbEventStats',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'data',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'newestCreatedAt',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, DbEventStats>(
    serialize: serializeDbEventStats,
    deserialize: deserializeDbEventStats,
    deserializeProperty: deserializeDbEventStatsProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDbEventStats(IsarWriter writer, DbEventStats object) {
  IsarCore.writeString(writer, 1, object.eventId);
  IsarCore.writeString(writer, 2, object.data);
  IsarCore.writeLong(writer, 3, object.newestCreatedAt);
  IsarCore.writeString(writer, 4, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
DbEventStats deserializeDbEventStats(IsarReader reader) {
  final String _eventId;
  _eventId = IsarCore.readString(reader, 1) ?? '';
  final String _data;
  _data = IsarCore.readString(reader, 2) ?? '';
  final int _newestCreatedAt;
  _newestCreatedAt = IsarCore.readLong(reader, 3);
  final object = DbEventStats(
    eventId: _eventId,
    data: _data,
    newestCreatedAt: _newestCreatedAt,
  );
  return object;
}

@isarProtected
dynamic deserializeDbEventStatsProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readLong(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DbEventStatsUpdate {
  bool call({
    required String id,
    String? eventId,
    String? data,
    int? newestCreatedAt,
  });
}

class _DbEventStatsUpdateImpl implements _DbEventStatsUpdate {
  const _DbEventStatsUpdateImpl(this.collection);

  final IsarCollection<String, DbEventStats> collection;

  @override
  bool call({
    required String id,
    Object? eventId = ignore,
    Object? data = ignore,
    Object? newestCreatedAt = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (eventId != ignore) 1: eventId as String?,
          if (data != ignore) 2: data as String?,
          if (newestCreatedAt != ignore) 3: newestCreatedAt as int?,
        }) >
        0;
  }
}

sealed class _DbEventStatsUpdateAll {
  int call({
    required List<String> id,
    String? eventId,
    String? data,
    int? newestCreatedAt,
  });
}

class _DbEventStatsUpdateAllImpl implements _DbEventStatsUpdateAll {
  const _DbEventStatsUpdateAllImpl(this.collection);

  final IsarCollection<String, DbEventStats> collection;

  @override
  int call({
    required List<String> id,
    Object? eventId = ignore,
    Object? data = ignore,
    Object? newestCreatedAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (eventId != ignore) 1: eventId as String?,
      if (data != ignore) 2: data as String?,
      if (newestCreatedAt != ignore) 3: newestCreatedAt as int?,
    });
  }
}

extension DbEventStatsUpdate on IsarCollection<String, DbEventStats> {
  _DbEventStatsUpdate get update => _DbEventStatsUpdateImpl(this);

  _DbEventStatsUpdateAll get updateAll => _DbEventStatsUpdateAllImpl(this);
}

sealed class _DbEventStatsQueryUpdate {
  int call({
    String? eventId,
    String? data,
    int? newestCreatedAt,
  });
}

class _DbEventStatsQueryUpdateImpl implements _DbEventStatsQueryUpdate {
  const _DbEventStatsQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DbEventStats> query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? data = ignore,
    Object? newestCreatedAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (eventId != ignore) 1: eventId as String?,
      if (data != ignore) 2: data as String?,
      if (newestCreatedAt != ignore) 3: newestCreatedAt as int?,
    });
  }
}

extension DbEventStatsQueryUpdate on IsarQuery<DbEventStats> {
  _DbEventStatsQueryUpdate get updateFirst =>
      _DbEventStatsQueryUpdateImpl(this, limit: 1);

  _DbEventStatsQueryUpdate get updateAll => _DbEventStatsQueryUpdateImpl(this);
}

class _DbEventStatsQueryBuilderUpdateImpl implements _DbEventStatsQueryUpdate {
  const _DbEventStatsQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DbEventStats, DbEventStats, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? data = ignore,
    Object? newestCreatedAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (eventId != ignore) 1: eventId as String?,
        if (data != ignore) 2: data as String?,
        if (newestCreatedAt != ignore) 3: newestCreatedAt as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension DbEventStatsQueryBuilderUpdate
    on QueryBuilder<DbEventStats, DbEventStats, QOperations> {
  _DbEventStatsQueryUpdate get updateFirst =>
      _DbEventStatsQueryBuilderUpdateImpl(this, limit: 1);

  _DbEventStatsQueryUpdate get updateAll =>
      _DbEventStatsQueryBuilderUpdateImpl(this);
}

extension DbEventStatsQueryFilter
    on QueryBuilder<DbEventStats, DbEventStats, QFilterCondition> {
  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataContains(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> dataMatches(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtGreaterThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtGreaterThanOrEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtLessThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtLessThanOrEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
      newestCreatedAtBetween(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idContains(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idMatches(
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

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterFilterCondition>
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

extension DbEventStatsQueryObject
    on QueryBuilder<DbEventStats, DbEventStats, QFilterCondition> {}

extension DbEventStatsQuerySortBy
    on QueryBuilder<DbEventStats, DbEventStats, QSortBy> {
  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortByDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy>
      sortByNewestCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy>
      sortByNewestCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> sortByIdDesc(
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

extension DbEventStatsQuerySortThenBy
    on QueryBuilder<DbEventStats, DbEventStats, QSortThenBy> {
  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenByDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy>
      thenByNewestCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy>
      thenByNewestCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DbEventStatsQueryWhereDistinct
    on QueryBuilder<DbEventStats, DbEventStats, QDistinct> {
  QueryBuilder<DbEventStats, DbEventStats, QAfterDistinct> distinctByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEventStats, DbEventStats, QAfterDistinct>
      distinctByNewestCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension DbEventStatsQueryProperty1
    on QueryBuilder<DbEventStats, DbEventStats, QProperty> {
  QueryBuilder<DbEventStats, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbEventStats, String, QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbEventStats, int, QAfterProperty> newestCreatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbEventStats, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbEventStatsQueryProperty2<R>
    on QueryBuilder<DbEventStats, R, QAfterProperty> {
  QueryBuilder<DbEventStats, (R, String), QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbEventStats, (R, String), QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbEventStats, (R, int), QAfterProperty>
      newestCreatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbEventStats, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension DbEventStatsQueryProperty3<R1, R2>
    on QueryBuilder<DbEventStats, (R1, R2), QAfterProperty> {
  QueryBuilder<DbEventStats, (R1, R2, String), QOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DbEventStats, (R1, R2, String), QOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DbEventStats, (R1, R2, int), QOperations>
      newestCreatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<DbEventStats, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
