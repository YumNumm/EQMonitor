import 'package:eqapi_types/eqapi_types.dart';
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
    int? serialNo,
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
    required ForecastMaxLgInt? forecastMaxLgInt,

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
    required int magnitudeCalculation,
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

List<int> stringListToIntList(List<dynamic> value) =>
    value.map((v) => int.parse(v.toString())).toList();
List<dynamic> intListToStringList(List<int> value) =>
    value.map((e) => e.toString()).toList();

@freezed
class ForecastMaxInt with _$ForecastMaxInt {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory ForecastMaxInt({
    required JmaForecastIntensity from,
    required JmaForecastIntensityOver to,
  }) = _ForecastMaxInt;

  factory ForecastMaxInt.fromJson(Map<String, dynamic> json) =>
      _$ForecastMaxIntFromJson(json);
}

@freezed
class ForecastMaxLgInt with _$ForecastMaxLgInt {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory ForecastMaxLgInt({
    required JmaForecastLgIntensity from,
    required JmaForecastLgIntensityOver to,
  }) = _ForecastMaxLgInt;

  factory ForecastMaxLgInt.fromJson(Map<String, dynamic> json) =>
      _$ForecastMaxLgIntFromJson(json);
}

extension ForecastMaxIntDisplay on ForecastMaxInt {
  // 表示する最大震度
  ({JmaForecastIntensity maxInt, bool isOver}) toDisplayMaxInt() {
    if (to == JmaForecastIntensityOver.over) {
      return (maxInt: from, isOver: true);
    } else {
      return (maxInt: to.toJmaForecastIntensity, isOver: false);
    }
  }
}

extension ForecastMaxLgIntDisplay on ForecastMaxLgInt {
  /// 表示する最大震度
  /// 推定最大長周期地震動階級0の場合、nullを返す
  /// 0以上の場合、推定最大長周期地震動階級を返す
  ({JmaForecastLgIntensity maxLgInt, bool isOver}) toDisplayMaxLgInt() {
    if (to == JmaForecastLgIntensityOver.over) {
      return (maxLgInt: from, isOver: true);
    }
    return (maxLgInt: to.toJmaForecastLgIntensity, isOver: false);
  }
}
