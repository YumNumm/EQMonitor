import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew.freezed.dart';
part 'eew.g.dart';

@freezed
class EewV1 with _$EewV1 implements V1Database {
  const factory EewV1({
    required int id,
    required int eventId,
    required String type,
    required String schemaType,
    required String status,
    required String infoType,
    required DateTime reportTime,
    int? serialno,
    String? headline,
    required bool isCanceled,
    bool? isWarning,
    required bool isLastInfo,
    DateTime? originTime,
    DateTime? arrivalTime,
    String? hypoName,
    int? depth,
    double? latitude,
    double? longitude,
    double? magnitude,
    JmaForecastIntensity? forecastMaxIntensity,
    bool? forecastMaxIntensityIsOver,
    JmaForecastLgIntensity? forecastMaxLpgmIntensity,
    bool? forecastMaxLpgmIntensityIsOver,
    List<EstimatedIntensityRegion>? regions,
    required bool? isPlum,
    required EewAccuracy? accuracy,
  }) = _EewV1;

  factory EewV1.fromJson(Map<String, dynamic> json) => _$EewV1FromJson(json);
}

@freezed
class EstimatedIntensityRegion with _$EstimatedIntensityRegion {
  const factory EstimatedIntensityRegion({
    required String code,
    required String name,
    @JsonKey(name: 'isPlum') required bool isPlum,
    @JsonKey(name: 'isWarning') required bool isWarning,
    @JsonKey(name: 'forecastMaxInt') required ForecastMaxInt forecastMaxInt,
    @JsonKey(name: 'forecastMaxLgInt')
    required ForecastMaxLgInt forecastMaxLgInt,

    /// nullの場合 `既に主要動到達と推測`
    @JsonKey(name: 'arrivalTime') required DateTime? arrivalTime,
  }) = _EstimatedIntensityRegion;

  factory EstimatedIntensityRegion.fromJson(Map<String, dynamic> json) =>
      _$EstimatedIntensityRegionFromJson(json);
}

@freezed
class EewAccuracy with _$EewAccuracy {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory EewAccuracy({
    /// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
    /// '0' | '1' | '2' | '3' | '4' | '9']
    @JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
    required List<int> epicenters,
    @JsonKey(fromJson: int.parse, toJson: intToString) required int depth,
    @JsonKey(fromJson: int.parse, toJson: intToString)
    required int magnitudeCalcuration,
    @JsonKey(fromJson: int.parse, toJson: intToString)
    required int numberOfMagnitudeCalculation,
  }) = _EewAccuracy;

  factory EewAccuracy.fromJson(Map<String, dynamic> json) =>
      _$EewAccuracyFromJson(json);
}

String intToString(int? value) {
  if (value == null) {
    return '';
  }
  return value.toString();
}

List<int> stringListToIntList(List<String> value) =>
    value.map(int.parse).toList();
List<String> intListToStringList(List<int> value) =>
    value.map((e) => e.toString()).toList();
