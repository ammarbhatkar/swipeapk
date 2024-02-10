// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocationCollectionCollection on Isar {
  IsarCollection<LocationCollection> get locationCollections =>
      this.collection();
}

const LocationCollectionSchema = CollectionSchema(
  name: r'LocationCollection',
  id: -8663811690448780975,
  properties: {
    r'lat': PropertySchema(
      id: 0,
      name: r'lat',
      type: IsarType.double,
    ),
    r'locationId': PropertySchema(
      id: 1,
      name: r'locationId',
      type: IsarType.long,
    ),
    r'long': PropertySchema(
      id: 2,
      name: r'long',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'radius': PropertySchema(
      id: 4,
      name: r'radius',
      type: IsarType.long,
    )
  },
  estimateSize: _locationCollectionEstimateSize,
  serialize: _locationCollectionSerialize,
  deserialize: _locationCollectionDeserialize,
  deserializeProp: _locationCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _locationCollectionGetId,
  getLinks: _locationCollectionGetLinks,
  attach: _locationCollectionAttach,
  version: '3.1.0+1',
);

int _locationCollectionEstimateSize(
  LocationCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _locationCollectionSerialize(
  LocationCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.lat);
  writer.writeLong(offsets[1], object.locationId);
  writer.writeDouble(offsets[2], object.long);
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.radius);
}

LocationCollection _locationCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocationCollection();
  object.id = id;
  object.lat = reader.readDouble(offsets[0]);
  object.locationId = reader.readLong(offsets[1]);
  object.long = reader.readDouble(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.radius = reader.readLong(offsets[4]);
  return object;
}

P _locationCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _locationCollectionGetId(LocationCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _locationCollectionGetLinks(
    LocationCollection object) {
  return [];
}

void _locationCollectionAttach(
    IsarCollection<dynamic> col, Id id, LocationCollection object) {
  object.id = id;
}

extension LocationCollectionQueryWhereSort
    on QueryBuilder<LocationCollection, LocationCollection, QWhere> {
  QueryBuilder<LocationCollection, LocationCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocationCollectionQueryWhere
    on QueryBuilder<LocationCollection, LocationCollection, QWhereClause> {
  QueryBuilder<LocationCollection, LocationCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocationCollectionQueryFilter
    on QueryBuilder<LocationCollection, LocationCollection, QFilterCondition> {
  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      latEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      latGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      latLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      latBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      locationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      locationIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      locationIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      locationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      longEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      longGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      longLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      longBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'long',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      radiusEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'radius',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      radiusGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'radius',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      radiusLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'radius',
        value: value,
      ));
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterFilterCondition>
      radiusBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'radius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocationCollectionQueryObject
    on QueryBuilder<LocationCollection, LocationCollection, QFilterCondition> {}

extension LocationCollectionQueryLinks
    on QueryBuilder<LocationCollection, LocationCollection, QFilterCondition> {}

extension LocationCollectionQuerySortBy
    on QueryBuilder<LocationCollection, LocationCollection, QSortBy> {
  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      sortByRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.desc);
    });
  }
}

extension LocationCollectionQuerySortThenBy
    on QueryBuilder<LocationCollection, LocationCollection, QSortThenBy> {
  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.asc);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QAfterSortBy>
      thenByRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.desc);
    });
  }
}

extension LocationCollectionQueryWhereDistinct
    on QueryBuilder<LocationCollection, LocationCollection, QDistinct> {
  QueryBuilder<LocationCollection, LocationCollection, QDistinct>
      distinctByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lat');
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QDistinct>
      distinctByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationId');
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QDistinct>
      distinctByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'long');
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocationCollection, LocationCollection, QDistinct>
      distinctByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'radius');
    });
  }
}

extension LocationCollectionQueryProperty
    on QueryBuilder<LocationCollection, LocationCollection, QQueryProperty> {
  QueryBuilder<LocationCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocationCollection, double, QQueryOperations> latProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lat');
    });
  }

  QueryBuilder<LocationCollection, int, QQueryOperations> locationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationId');
    });
  }

  QueryBuilder<LocationCollection, double, QQueryOperations> longProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'long');
    });
  }

  QueryBuilder<LocationCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<LocationCollection, int, QQueryOperations> radiusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'radius');
    });
  }
}
