import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum TopoJsonGeometryType {
  polygon('Polygon'),
  multiPolygon('MultiPolygon'),
  geometryCollection('GeometryCollection'),
  lineString('LineString'),
  multiLineString('MultiLineString');

  const TopoJsonGeometryType(this.type);
  final String type;
}
