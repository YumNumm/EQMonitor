import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:topojson/src/topo_json_geometry_type.dart';

part 'topo_json_geometry.freezed.dart';
part 'topo_json_geometry.g.dart';

sealed class TopoJsonGeometryObject {
  final TopoJsonGeometryType? type;
  final Map<String, String>? properties;

  const TopoJsonGeometryObject({
    this.type,
    this.properties,
  });

  factory TopoJsonGeometryObject.fromJson(Map<String, dynamic> json) {
    final type = TopoJsonGeometryType.values
        .firstWhereOrNull((e) => e.type == json['type']);
    switch (type) {
      case TopoJsonGeometryType.polygon:
        return Polygon.fromJson(json);
      case TopoJsonGeometryType.multiPolygon:
        return MultiPolygon.fromJson(json);
      case TopoJsonGeometryType.geometryCollection:
        return GeometryCollection.fromJson(json);
      case TopoJsonGeometryType.lineString:
        return LineString.fromJson(json);
      case TopoJsonGeometryType.multiLineString:
        return MultiLineString.fromJson(json);
      case null:
        return NullGeometryObject.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    switch (type) {
      case TopoJsonGeometryType.polygon:
        return (this as Polygon).toJson();
      case TopoJsonGeometryType.multiPolygon:
        return (this as MultiPolygon).toJson();
      case TopoJsonGeometryType.geometryCollection:
        return (this as GeometryCollection).toJson();
      case TopoJsonGeometryType.lineString:
        return (this as LineString).toJson();
      case TopoJsonGeometryType.multiLineString:
        return (this as MultiLineString).toJson();
      case null:
        return {
          if (properties != null)
            "properties": (properties as dynamic).toJson(),
          "type": null,
        };
    }
  }
}

// 2.1.1 Positions
typedef Positions = List<double>;

// 2.1.3 Arcs
typedef Arc = List<Positions>;

// 2.1.4 Arc Indexes
typedef ArcIndexes = List<int>;

@freezed
class LineString with _$LineString implements TopoJsonGeometryObject {
  const factory LineString({
    required TopoJsonGeometryType type,
    required ArcIndexes arcs,
    required Map<String, String>? properties,
  }) = _LineString;

  factory LineString.fromJson(Map<String, dynamic> json) =>
      _$LineStringFromJson(json);
}

@freezed
class MultiLineString with _$MultiLineString implements TopoJsonGeometryObject {
  const factory MultiLineString({
    required TopoJsonGeometryType type,
    required List<ArcIndexes> arcs,
    required Map<String, String>? properties,
  }) = _MultiLineString;

  factory MultiLineString.fromJson(Map<String, dynamic> json) =>
      _$MultiLineStringFromJson(json);
}

@freezed
class Polygon with _$Polygon implements TopoJsonGeometryObject {
  const factory Polygon({
    required TopoJsonGeometryType type,
    required List<ArcIndexes> arcs,
    required Map<String, String>? properties,
  }) = _Polygon;

  factory Polygon.fromJson(Map<String, dynamic> json) =>
      _$PolygonFromJson(json);
}

@freezed
class MultiPolygon with _$MultiPolygon implements TopoJsonGeometryObject {
  const factory MultiPolygon({
    required TopoJsonGeometryType type,
    required List<List<ArcIndexes>> arcs,
    required Map<String, String>? properties,
  }) = _MultiPolygon;

  factory MultiPolygon.fromJson(Map<String, dynamic> json) =>
      _$MultiPolygonFromJson(json);
}

@freezed
class GeometryCollection
    with _$GeometryCollection
    implements TopoJsonGeometryObject {
  const factory GeometryCollection({
    required TopoJsonGeometryType type,
    required List<TopoJsonGeometryObject> geometries,
    required Map<String, String>? properties,
  }) = _GeometryCollection;

  factory GeometryCollection.fromJson(Map<String, dynamic> json) =>
      _$GeometryCollectionFromJson(json);
}

@freezed
class NullGeometryObject
    with _$NullGeometryObject
    implements TopoJsonGeometryObject {
  const factory NullGeometryObject({
    required TopoJsonGeometryType? type,
    required Map<String, String>? properties,
  }) = _NullGeometryObject;

  factory NullGeometryObject.fromJson(Map<String, dynamic> json) =>
      _$NullGeometryObjectFromJson(json);
}
