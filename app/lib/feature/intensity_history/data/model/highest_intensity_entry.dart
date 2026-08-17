import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'highest_intensity_entry.freezed.dart';
part 'highest_intensity_entry.g.dart';

@freezed
abstract class HighestIntensityEntry with _$HighestIntensityEntry {
  const factory({
    /// 気象庁防災情報XMLフォーマットの地域コード。
    required String code,

    /// 地域名。
    required String name,

    /// 過去最高震度。
    required JmaIntensity intensity,

    /// 同震度を観測した地震の件数。
    required int count,

    /// 最高震度を観測した直近の地震イベント。
    required EarthquakePartial earthquake,
  }) = _HighestIntensityEntry;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$HighestIntensityEntryFromJson(json);
}

extension HighestIntensityEntryApiExtension on api.HighestIntensityItem {
  HighestIntensityEntry toAppEntry({required EarthquakeParameter parameter}) =>
      HighestIntensityEntry(
        code: code,
        name: name,
        intensity: intensity.toJmaIntensity,
        count: count,
        earthquake: earthquake.toEarthquakePartial(parameter: parameter),
      );
}
