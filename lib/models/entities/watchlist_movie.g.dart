// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_movie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchlistMovieCollection on Isar {
  IsarCollection<WatchlistMovie> get watchlistMovies => this.collection();
}

const WatchlistMovieSchema = CollectionSchema(
  name: r'WatchlistMovie',
  id: -298808979612091411,
  properties: {
    r'addedAt': PropertySchema(
      id: 0,
      name: r'addedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _watchlistMovieEstimateSize,
  serialize: _watchlistMovieSerialize,
  deserialize: _watchlistMovieDeserialize,
  deserializeProp: _watchlistMovieDeserializeProp,
  idName: r'movieId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _watchlistMovieGetId,
  getLinks: _watchlistMovieGetLinks,
  attach: _watchlistMovieAttach,
  version: '3.1.0+1',
);

int _watchlistMovieEstimateSize(
  WatchlistMovie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.addedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _watchlistMovieSerialize(
  WatchlistMovie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.addedAt);
}

WatchlistMovie _watchlistMovieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchlistMovie();
  object.addedAt = reader.readStringOrNull(offsets[0]);
  object.movieId = id;
  return object;
}

P _watchlistMovieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchlistMovieGetId(WatchlistMovie object) {
  return object.movieId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _watchlistMovieGetLinks(WatchlistMovie object) {
  return [];
}

void _watchlistMovieAttach(
    IsarCollection<dynamic> col, Id id, WatchlistMovie object) {
  object.movieId = id;
}

extension WatchlistMovieQueryWhereSort
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QWhere> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhere> anyMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WatchlistMovieQueryWhere
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QWhereClause> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdEqualTo(Id movieId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: movieId,
        upper: movieId,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdNotEqualTo(Id movieId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: movieId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: movieId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: movieId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: movieId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdGreaterThan(Id movieId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: movieId, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdLessThan(Id movieId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: movieId, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdBetween(
    Id lowerMovieId,
    Id upperMovieId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerMovieId,
        includeLower: includeLower,
        upper: upperMovieId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchlistMovieQueryFilter
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addedAt',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addedAt',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      addedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'movieId',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'movieId',
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'movieId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchlistMovieQueryObject
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {}

extension WatchlistMovieQueryLinks
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {}

extension WatchlistMovieQuerySortBy
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QSortBy> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> sortByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      sortByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }
}

extension WatchlistMovieQuerySortThenBy
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QSortThenBy> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> thenByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      thenByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> thenByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      thenByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }
}

extension WatchlistMovieQueryWhereDistinct
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QDistinct> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QDistinct> distinctByAddedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAt', caseSensitive: caseSensitive);
    });
  }
}

extension WatchlistMovieQueryProperty
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QQueryProperty> {
  QueryBuilder<WatchlistMovie, int, QQueryOperations> movieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieId');
    });
  }

  QueryBuilder<WatchlistMovie, String?, QQueryOperations> addedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAt');
    });
  }
}
