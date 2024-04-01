import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/v1/v1_database.dart';
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
