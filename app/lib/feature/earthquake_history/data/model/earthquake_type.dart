import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

/// 地震種別
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum EarthquakeType {
  /// 通常の地震
  normal,

  /// 遠地地震 (海外で規模の大きな地震)
  distant,

  /// 火山噴火 (海外の大規模な噴火)
  volcano,
}

extension EarthquakeTypeApiExtension on api.EarthquakeType {
  EarthquakeType get toEarthquakeType => switch (this) {
    .normal => .normal,
    .distant => .distant,
    .volcano => .volcano,
  };
}

extension EarthquakeTypeToApiExtension on EarthquakeType {
  api.EarthquakeType get toApiEarthquakeType => switch (this) {
    .normal => .normal,
    .distant => .distant,
    .volcano => .volcano,
  };
}
