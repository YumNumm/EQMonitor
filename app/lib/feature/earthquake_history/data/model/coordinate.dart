import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinate.freezed.dart';
part 'coordinate.g.dart';

@freezed
sealed class Coordinate with _$Coordinate {
  const factory Coordinate.unknown() = CoordinateUnknown;

  const factory Coordinate.latLng({
    required double latitude,
    required double longitude,
  }) = CoordinateLatLng;

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
}

extension CoordinateApiExtension on api.Coordinate {
  Coordinate get toCoordinate => Coordinate.latLng(
    latitude: latitude.toDouble(),
    longitude: longitude.toDouble(),
  );
}
