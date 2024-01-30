import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

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
    List<int>? maxIntensityREgionIds,
  }) = _EarthquakeV1;

  factory EarthquakeV1.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeV1FromJson(json);
}
