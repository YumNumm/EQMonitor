import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_activity_query.freezed.dart';

@freezed
abstract class EarthquakeActivityQuery with _$EarthquakeActivityQuery {
  const factory EarthquakeActivityQuery({
    required String baseEventId,
    required DateTime baseOriginTime,
    required double latitude,
    required double longitude,
    required int? depth,
    required int beforeDays,
    required int afterDays,
    required int radiusKm,
    required int? depthOffsetKm,
  }) = _EarthquakeActivityQuery;

  const EarthquakeActivityQuery._();

  DateTime get start => baseOriginTime.subtract(Duration(days: beforeDays));

  DateTime get requestedEnd => baseOriginTime.add(Duration(days: afterDays));

  DateTime effectiveEnd({required DateTime now}) => requestedEnd.isBefore(now)
      ? requestedEnd
      : now;

  int? get depthGte => switch ((depth, depthOffsetKm)) {
    (final int value, final int offset) => (value - offset).clamp(0, 2000),
    _ => null,
  };

  int? get depthLte => switch ((depth, depthOffsetKm)) {
    (final int value, final int offset) => (value + offset).clamp(0, 2000),
    _ => null,
  };
}
