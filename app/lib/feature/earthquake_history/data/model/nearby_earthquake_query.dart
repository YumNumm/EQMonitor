import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_earthquake_query.freezed.dart';

@freezed
abstract class NearbyEarthquakeQuery with _$NearbyEarthquakeQuery {
  const factory NearbyEarthquakeQuery({
    required String excludeEventId,
    required double latitude,
    required double longitude,
    required int? depth,
    required NearbyEarthquakeParameter parameter,
    required EarthquakeSortBy sortBy,
    required SortOrder sortOrder,
  }) = _NearbyEarthquakeQuery;

  const NearbyEarthquakeQuery._();

  double get latitudeGte =>
      (latitude - parameter.latitudeOffset).clamp(-90, 90).toDouble();

  double get latitudeLte =>
      (latitude + parameter.latitudeOffset).clamp(-90, 90).toDouble();

  double get longitudeGte =>
      (longitude - parameter.longitudeOffset).clamp(-180, 180).toDouble();

  double get longitudeLte =>
      (longitude + parameter.longitudeOffset).clamp(-180, 180).toDouble();

  int? get depthGte => switch (depth) {
    final int value => (value - parameter.depthOffset).clamp(0, 2000),
    null => null,
  };

  int? get depthLte => switch (depth) {
    final int value => (value + parameter.depthOffset).clamp(0, 2000),
    null => null,
  };
}
