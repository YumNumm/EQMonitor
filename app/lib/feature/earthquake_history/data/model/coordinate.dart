import 'package:eqmonitor_api/export.dart' as api;
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
  Coordinate get toCoordinate => switch (type) {
    .latLng => .latLng(
      latitude:
          latitude?.toDouble() ??
          (throw CheckedFromJsonException(
            toJson(),
            'latitude',
            'Coordinate',
            'latitude',
          )),
      longitude:
          longitude?.toDouble() ??
          (throw CheckedFromJsonException(
            toJson(),
            'longitude',
            'Coordinate',
            'longitude',
          )),
    ),
    .unknown => const .unknown(),
  };
}
