import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_hypocenter.freezed.dart';
part 'earthquake_hypocenter.g.dart';

@freezed
abstract class EarthquakeHypocenter with _$EarthquakeHypocenter {
  const factory EarthquakeHypocenter({
    required String code,
    required String name,
    required Coordinate coordinates,
    required EarthquakeMagnitude magnitude,
    required EarthquakeDepth depth,
    required String? detailedCode,
    required String? detailedName,
  }) = _EarthquakeHypocenter;

  factory EarthquakeHypocenter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterFromJson(json);
}

extension EarthquakeHypocenterApiExtension on api.Hypocenter {
  EarthquakeHypocenter get toEarthquakeHypocenter => EarthquakeHypocenter(
    code: value.code,
    name: value.name,
    coordinates: coordinates.toCoordinate,
    magnitude: magnitude.toEarthquakeMagnitude,
    depth: depth.toEarthquakeDepth,
    detailedCode: detailed?.code,
    detailedName: detailed?.name,
  );
}
