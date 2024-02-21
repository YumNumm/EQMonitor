import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@freezed
class EarthquakeBaseComponent with _$EarthquakeBaseComponent {
  const factory EarthquakeBaseComponent({
    required int id,
    required int eventId,
    required String status,
    double? magnitude,
    String? magnitudeCondition,
    JmaIntensity? maxIntensity,
    JmaLgIntensity? maxLpgmIntensity,
    int? depth,
    double? latitude,
    double? longitude,
    int? epicenterCode,
    int? epicenterDetailCode,
    DateTime? arrivalTime,
    DateTime? originTime,
    String? latestHeadline,
    List<int>? maxIntensityRegionIds,
  }) = _EarthquakeBaseComponent;

  factory EarthquakeBaseComponent.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeBaseComponentFromJson(json);
}

@freezed
class EarthquakeV1 with _$EarthquakeV1 {
  const factory EarthquakeV1({
    required int id,
    required int eventId,
    required String status,
    double? magnitude,
    String? magnitudeCondition,
    JmaIntensity? maxIntensity,
    JmaLgIntensity? maxLpgmIntensity,
    int? depth,
    double? latitude,
    double? longitude,
    int? epicenterCode,
    int? epicenterDetailCode,
    DateTime? arrivalTime,
    DateTime? originTime,
    String? latestHeadline,
    List<int>? maxIntensityRegionIds,
  }) = _EarthquakeV1;

  factory EarthquakeV1.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeV1FromJson(json);
}

sealed class IntensityObservationBase {
  IntensityObservationBase({
    required this.code,
    required this.name,
    required this.maxInt,
  });

  final String code;
  final String name;
  final JmaIntensity maxInt;
}

@freezed
class IntensityObservationItem
    with _$IntensityObservationItem
    implements IntensityObservationBase {
  const factory IntensityObservationItem({
    required String code,
    required String name,
    required JmaIntensity maxInt,
  }) = _IntensityObservationItem;

  factory IntensityObservationItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityObservationItemFromJson(json);
}

@freezed
class LgIntensityObservationItem
    with _$LgIntensityObservationItem
    implements IntensityObservationBase {
  const factory LgIntensityObservationItem({
    required String code,
    required String name,
    required JmaIntensity maxInt,
    required JmaLgIntensity lgMaxInt,
  }) = _LgIntensityObservationItem;

  factory LgIntensityObservationItem.fromJson(Map<String, dynamic> json) =>
      _$LgIntensityObservationItemFromJson(json);
}
