import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

class ParameterPointConverter
    implements JsonConverter<Point<double>, Map<String, dynamic>> {
  const ParameterPointConverter();

  @override
  Point<double> fromJson(Map<String, dynamic> json) => Point<double>(
    (json['x'] as num).toDouble(),
    (json['y'] as num).toDouble(),
  );

  @override
  Map<String, dynamic> toJson(Point<double> object) => {
    'x': object.x,
    'y': object.y,
  };
}
